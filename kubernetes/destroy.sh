terraform destroy \
  -var "environment=${TERRAFORM_ENVIRONMENT?}" \
  -var "location=${TERRAFORM_LOCATION?}"
