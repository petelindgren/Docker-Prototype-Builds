#!/bin/sh
if [ -z "${AWS_LAMBDA_RUNTIME_API}" ]; then
  exec /usr/local/bin/aws-lambda-rie /usr/local/bin/python -m awslambdaric lambda_function.handler
else
  # This is the same command executed as combination of the Dockerfile ENTRYPOINT and CMD
  exec /usr/local/bin/python -m awslambdaric lambda_function.handler
fi