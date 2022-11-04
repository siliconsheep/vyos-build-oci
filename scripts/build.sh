#!/usr/bin/env bash

VYOS_VERSION_NUMBER=$(cat data/versions | jq -r 'first(.[])')

./configure \
  --architecture amd64 \
  --build-by "dieterbocklandt@gmail.com" \
  --build-type release \
  --version "${VYOS_VERSION_NUMBER}"

sudo make oracle