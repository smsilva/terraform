FROM hashicorp/terraform:${TERRAFORM_VERSION} AS terraform_base_image
ENV LOCK_TIMEOUT_SECONDS=300
RUN mkdir -p /opt/output/

FROM terraform_base_image AS package
ADD azurerm.conf /opt/credentials/azurerm.conf
ADD stack.conf /opt/src/stack.conf
ADD .ssh/ /root/.ssh/
RUN chmod 600 /root/.ssh/config
COPY scripts/* /opt/scripts/
ADD src/ /opt/src
WORKDIR /opt/src
RUN /opt/scripts/init-remote-backend

FROM terraform_base_image AS final
ENV DEBUG="1"
COPY --from=package /opt/src /opt/src
COPY --from=package /opt/scripts/ /opt/scripts/
WORKDIR /opt/src
ENTRYPOINT ["/opt/scripts/entrypoint"]
