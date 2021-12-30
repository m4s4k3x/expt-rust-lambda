#!/bin/bash

LAMBDA_ARCH="linux/amd64"
RUST_TARGET="x86_64-unknown-linux-gnu"
RUST_VERSION="1.57.0"

docker run \
  --platform ${LAMBDA_ARCH} \
  --rm --user "$(id -u)":"$(id -g)" \
  -v "${PWD}":/usr/src/myapp -w /usr/src/myapp rust:${RUST_VERSION} \
  cargo build --release --target ${RUST_TARGET}
