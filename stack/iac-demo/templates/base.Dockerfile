FROM hashicorp/terraform:${TERRAFORM_VERSION} AS base
RUN mkdir -p /stack/output
WORKDIR /stack
ADD ./scripts/run /stack/run
ADD ./src /stack
RUN terraform init

FROM base AS package

FROM package AS final
WORKDIR /stack
ENTRYPOINT ["/stack/run"]
