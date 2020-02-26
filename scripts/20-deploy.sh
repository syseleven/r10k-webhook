#!/usr/bin/env sh

if [ "${DEPLOY_CONTROL_ON_START}" == "true" ]; then
  /usr/local/bin/r10k-control
fi
