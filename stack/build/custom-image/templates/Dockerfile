FROM ${STACK_IMAGE}:${STACK_VERSION} AS stack_base_image

FROM stack_base_image AS package
ADD terraform.tfvars /opt/src/terraform.tfvars
ADD backend.conf /opt/src/backend.conf
ADD azurerm.conf /opt/credentials/azurerm.conf
WORKDIR /opt/src
RUN /opt/scripts/init-remote-backend

FROM stack_base_image AS final
COPY --from=package /opt/src/.terraform/terraform.tfstate /opt/src/.terraform/terraform.tfstate
COPY --from=package /opt/src/.terraform.lock.hcl /opt/src/.terraform.lock.hcl
ADD terraform.tfvars /opt/src/terraform.tfvars
ADD backend.conf /opt/src/backend.conf
ENV ENVIRONMENT_NAME="${ENVIRONMENT_NAME}"
ENV ENVIRONMENT_REGION="${ENVIRONMENT_REGION}"
ENV DEBUG="0"
WORKDIR /opt/src
ENTRYPOINT ["/opt/scripts/run"]
