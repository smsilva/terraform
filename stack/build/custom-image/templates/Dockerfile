FROM ${STACK_IMAGE}:${STACK_VERSION}
ADD terraform.tfvars /stack/terraform.tfvars
ADD backend.conf /stack/backend.conf
ENV ENVIRONMENT_NAME="${ENVIRONMENT_NAME}"
ENV ENVIRONMENT_REGION="${ENVIRONMENT_REGION}"
WORKDIR /stack
ENTRYPOINT ["/stack/run"]
