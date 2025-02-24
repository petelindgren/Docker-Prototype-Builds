# Using an AWS base image for Python

This folder is a direct copy of the AWS documentation for
[Using an AWS base image for Python](https://docs.aws.amazon.com/lambda/latest/dg/python-image.html#python-image-instructions)


## Build Docker Image and Run Docker Container

### Build Image and Run Container on macOS

1.  Build Docker Image

    ```
    docker buildx build --platform linux/arm64 --provenance=false -t lambda-aws-base-image:01 .
    ```


2.  Run Docker Image

    ```
    docker run --platform linux/arm64 -p 9000:8080 lambda-aws-base-image:01
    ```


### Build Image and Run Container on x86

1.  Build Docker Image

    ```
    docker buildx build --platform linux/amd64 --provenance=false -t lambda-aws-base-image:01 .
    ```

2.  Run Docker Image

    ```
    docker run --platform linux/amd64 -p 9000:8080 lambda-aws-base-image:01:test
    ```

## Submit Requests

3.  Post event to the local endpoint

    ```
    curl "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{}'
    ```

3.  Post event to the local endpoint with a JSON payload

    ```
    curl "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{"payload":"hello world!"}'
    ```
