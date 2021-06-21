#!/bin/bash

curl \
  --silent \
  --header 'Accept: application/json' \
  --user ${ENV0_API_KEY?}:${ENV0_API_SECRET?} \
  "https://api.env0.com/blueprints?organizationId=${ENV0_ORGANIZATION?}" | jq
