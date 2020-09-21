#!/bin/bash

TEAM=main
PIPELINE_NAME=helm-charts-ci

# https://stackoverflow.com/questions/59895/how-to-get-the-source-directory-of-a-bash-script-from-within-the-script-itself
CI_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
fly set-pipeline -t $TEAM -c $CI_DIR/pipeline.yaml -p $PIPELINE_NAME
