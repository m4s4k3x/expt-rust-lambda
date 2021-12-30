#!/bin/bash

set -ue

LAMBDA_ARCH="linux/amd64"
RUST_TARGET="x86_64-unknown-linux-gnu"
RUST_VERSION="1.57.0"
FUNC_NAME=test-rust-lambda-001
ZIP_PATH=dist/lambda.zip

docker run \
  --platform ${LAMBDA_ARCH} \
  --rm --user "$(id -u)":"$(id -g)" \
  -v "${PWD}":/usr/src/myapp \
  -w /usr/src/myapp rust:${RUST_VERSION} \
  cargo build --release --target ${RUST_TARGET}

rm -rf dist/*
zip -j ${ZIP_PATH} "./target/${RUST_TARGET}/release/bootstrap"

aws lambda update-function-code --function-name ${FUNC_NAME} --zip-file "fileb://${ZIP_PATH}"
