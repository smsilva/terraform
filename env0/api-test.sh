#!/bin/bash

curl \
  --silent \
  --header 'Accept: application/json' \
  --user ${ENV0_API_KEY_ID?}:${ENV0_API_KEY_SECRET?} \
  "https://api.env0.com/blueprints?organizationId=${ENV0_ORGANIZATION_ID?}" | jq
