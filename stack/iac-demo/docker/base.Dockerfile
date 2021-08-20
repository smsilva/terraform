FROM hashicorp/terraform:1.0.5 AS base

FROM base AS package
RUN mkdir -p /stack/output
WORKDIR /stack
ADD ./scripts/run /stack/run
ADD ./scripts/init /stack/init
ADD ./src /stack
ADD ./.ssh /root/.ssh/
RUN chmod 600 /root/.ssh/config
RUN /stack/init

FROM base AS final
COPY --from=package /stack/ /stack/
WORKDIR /stack
ENTRYPOINT ["/stack/run"]
