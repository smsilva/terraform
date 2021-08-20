FROM ${BASE_IMAGE_NAME}:${BASE_IMAGE_VERSION}
ADD provider.tf /stack/provider.tf
ADD backend.conf /stack/backend.conf
ADD terraform.tfvars /stack/terraform.tfvars
RUN chmod +x /stack/run
WORKDIR /stack
ENTRYPOINT ["/stack/run"]
