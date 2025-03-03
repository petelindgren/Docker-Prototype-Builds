#!/usr/bin/env bash

set -e

help() {
    echo "Help"
    echo ""
    echo "run_lambda replaces the AWS Tutorial ENTRYPOINT and CMD"
}

case "$1" in
    run_lambda)
        shift
        /usr/local/bin/python -m awslambdaric lambda_function.handler
        ;;
    help)
        shift
        help
        ;;
    *)
        "@"
        ;;
esac
