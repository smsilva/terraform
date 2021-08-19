# Demo Stack

Work in progress.

See: https://stackoverflow.com/questions/67476870/how-to-run-terraform-apply-auto-approve-in-docker-container-using-cmd

```bash
docker build \
  -t iac-stack:1.0.0 \
  -f docker/base.Dockerfile .

docker build \
  -t iac-stack-stage:1.0.0 \
  -f docker/stage.Dockerfile .

docker run \
  -e ARM_CLIENT_ID=${ARM_CLIENT_ID?} \
  -e ARM_CLIENT_SECRET=${ARM_CLIENT_SECRET?} \
  -e ARM_SUBSCRIPTION_ID=${ARM_SUBSCRIPTION_ID?} \
  -e ARM_TENANT_ID=${ARM_TENANT_ID?} \
  -e ARM_ACCESS_KEY=${ARM_ACCESS_KEY?} \
  iac-stack-stage:1.0.0 -chdir=src init -get=false 

docker run \
  -e ARM_CLIENT_ID=${ARM_CLIENT_ID?} \
  -e ARM_CLIENT_SECRET=${ARM_CLIENT_SECRET?} \
  -e ARM_SUBSCRIPTION_ID=${ARM_SUBSCRIPTION_ID?} \
  -e ARM_TENANT_ID=${ARM_TENANT_ID?} \
  -e ARM_ACCESS_KEY=${ARM_ACCESS_KEY?} \
  iac-stack-stage:1.0.0 -chdir=src plan
```
