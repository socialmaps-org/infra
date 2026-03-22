#!/usr/bin/env sh
set -eux

tflint --format=compact --chdir=terraform/
