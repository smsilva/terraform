terraform plan \
  -var "environment=${TERRAFORM_ENVIRONMENT?}" \
  -var "location=${TERRAFORM_LOCATION?}" \
  -out .terraform.plan
