FROM hashicorp/terraform:1.0.5 AS base
RUN mkdir -p /stack/output
WORKDIR /stack
ADD ./scripts/run /stack/run
ADD ./scripts/init /stack/init
ADD ./src /stack
ADD ./.ssh /root/
RUN chmod 600 /root/.ssh/config
RUN /stack/init

FROM base AS package
RUN rm -rf /root/.ssh

FROM package AS final
WORKDIR /stack
ENTRYPOINT ["/stack/run"]
