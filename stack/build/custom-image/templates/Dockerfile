FROM ${STACK_IMAGE}:${STACK_VERSION} AS base
ADD terraform.tfvars /stack/terraform.tfvars
ADD backend.conf /stack/backend.conf

FROM base AS package
ADD azurerm.conf /stack/azurerm.conf
RUN /stack/init-remote-backend

FROM base AS final
ENV ENVIRONMENT_NAME="${ENVIRONMENT_NAME}"
ENV ENVIRONMENT_REGION="${ENVIRONMENT_REGION}"
ENV DEBUG="0"
COPY --from=package /stack /stack/
WORKDIR /stack
ENTRYPOINT ["/stack/run"]
