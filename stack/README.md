# Demo Stack

Work in progress.

See: https://stackoverflow.com/questions/67476870/how-to-run-terraform-apply-auto-approve-in-docker-container-using-cmd

```bash
docker run \
  -v ${PWD}/output:/stack/output/ \
  -e ARM_CLIENT_ID=${ARM_CLIENT_ID?} \
  -e ARM_CLIENT_SECRET=${ARM_CLIENT_SECRET?} \
  -e ARM_SUBSCRIPTION_ID=${ARM_SUBSCRIPTION_ID?} \
  -e ARM_TENANT_ID=${ARM_TENANT_ID?} \
  -e ARM_ACCESS_KEY=${ARM_ACCESS_KEY?} \
  iac-stack-stage:1.0.0 terraform apply -auto-approve /stack/output/terraform.plan
```
