FROM hashicorp/terraform:1.0.5 AS base
RUN mkdir -p /stack/output
ADD ./scripts/run /stack/run
ADD ./src /stack
WORKDIR /stack
RUN terraform init

FROM base AS package
RUN find /stack
RUN rm -rf /stack/.terraform.lock.hcl
RUN rm -rf /stack/.terraform/terraform.tfstate

FROM package AS final
WORKDIR /stack
ENTRYPOINT /stack/run
