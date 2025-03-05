#!/usr/bin/env bash

set -e

help() {
    echo "Help"
    echo ""
    echo "run_lambda replaces the AWS Tutorial ENTRYPOINT and CMD"
}

set_aws_lambda_runtime()
{
    if [ -z "${AWS_LAMBDA_RUNTIME_API}" ]; then
        RUNTIME="/usr/local/bin/aws-lambda-rie /usr/local/bin/python -m awslambdaric"
    else
        # Set default runtime
        RUNTIME="/usr/local/bin/python -m awslambdaric"
    fi
}

set_aws_lambda_runtime
# echo "exec lambda with runtime: '${RUNTIME}'"

case "$1" in
    run_lambda1)
        shift
        ${RUNTIME} lambda_function1.handler
        ;;
    run_lambda2)
        shift
        ${RUNTIME} lambda_function2.handler
        ;;
    help)
        shift
        help
        ;;
    *)
        "@"
        ;;
esac
