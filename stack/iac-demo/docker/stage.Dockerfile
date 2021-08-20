FROM iac-stack:1.0.0
ADD ./templates/provider.tf /stack/provider.tf
ADD ./variables/stage.tfvars /stack/terraform.tfvars
RUN find /stack
RUN cat /stack/run
RUN chmod +x /stack/run
WORKDIR /stack
ENTRYPOINT /stack/run
