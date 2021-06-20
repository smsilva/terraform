#!/bin/bash

set -e

az ad sp create-for-rbac \
  --name "env0" \
  --role "Contributor" \
  --scopes "/subscriptions/${ARM_SUBSCRIPTION_ID?}"

az login \
  --service-principal \
  --username "${ARM_CLIENT_ID?}" \
  --password "$(echo ${ARM_CLIENT_SECRET?} | base64 -d)" \
  --tenant "${ARM_TENANT_ID?}"
