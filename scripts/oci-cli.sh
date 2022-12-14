#!/usr/bin/env bash

docker run --rm ${2} \
  -e OCI_CLI_USER \
  -e OCI_CLI_TENANCY \
  -e OCI_CLI_FINGERPRINT \
  -e OCI_CLI_KEY_CONTENT \
  -e OCI_CLI_REGION \
  ghcr.io/oracle/oci-cli:latest ${1}