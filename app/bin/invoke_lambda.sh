#!/bin/bash
set -eu

FUNC_NAME=test-rust-lambda-001

aws lambda invoke --function-name "$FUNC_NAME" \
  "/tmp/${FUNC_NAME}_out"
