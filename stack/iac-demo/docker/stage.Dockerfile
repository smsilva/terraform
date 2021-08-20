FROM iac-stack:1.0.0
ADD ./templates/provider.tf /stack/provider.tf
ADD ./templates/backend.conf /stack/backend.conf
ADD ./variables/stage.tfvars /stack/terraform.tfvars
RUN chmod +x /stack/run
WORKDIR /stack
ENTRYPOINT ["/stack/run"]
