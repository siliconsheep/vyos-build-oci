#!/usr/bin/env bash

./configure \
  --architecture amd64 \
  --build-by "dieterbocklandt@gmail.com" \
  --build-type release \
  --version "${VYOS_VERSION_NO}"

sudo make oracle