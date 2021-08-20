FROM hashicorp/terraform:1.0.5 AS base
RUN mkdir -p /stack/output
WORKDIR /stack
ADD ./scripts/run /stack/run
ADD ./src /stack
RUN terraform init

FROM base AS package
# RUN rm -rf /stack/provider.tf

FROM package AS final
WORKDIR /stack
ENTRYPOINT ["/stack/run"]
