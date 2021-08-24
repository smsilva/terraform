FROM hashicorp/terraform:${TERRAFORM_VERSION} AS base

FROM base AS package
RUN mkdir -p /stack/output
WORKDIR /stack
COPY scripts/* /stack/
ADD src/ /stack
ADD .ssh/ /root/.ssh/
RUN chmod 600 /root/.ssh/config
RUN /stack/init-local-backend

FROM base AS final
COPY --from=package /stack /stack/
WORKDIR /stack
ENTRYPOINT ["/stack/run"]
