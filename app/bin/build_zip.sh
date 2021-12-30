#!/bin/bash
set -ue

rm -rf dist/*
zip -j dist/lambda.zip ./target/x86_64-unknown-linux-gnu/release/bootstrap
