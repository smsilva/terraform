FROM ${BASE_IMAGE_NAME}:${STACK_VERSION}
ADD provider.tf /stack/provider.tf
ADD backend.conf /stack/backend.conf
ADD config /stack/config
ADD terraform.tfvars /stack/terraform.tfvars
RUN chmod +x /stack/run
WORKDIR /stack
ENTRYPOINT ["/stack/run"]
