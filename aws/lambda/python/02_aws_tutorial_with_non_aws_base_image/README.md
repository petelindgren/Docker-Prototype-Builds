# Using a non-AWS base image for Python with AWS Runtime Interface Emulator installed locally

This folder is a direct copy of the AWS documentation for
[Using an alternative base image with the runtime interface client](https://docs.aws.amazon.com/lambda/latest/dg/python-image.html#python-image-clients)


References
- To make the image compatible with Lambda, you must include a [runtime interface client]() for your language in the image.


## Build Docker Image and Run Docker Container

### Build Image and Run Container on macOS

-   Build Docker Image

    ```sh
    docker buildx build --platform linux/arm64 --provenance=false -t lambda-image-02-non-aws-base:aws-tutorial .
    ```

-   Install Runtime Interface Emulator locally

    ```sh
    mkdir -p ~/.aws-lambda-rie && \
        curl -Lo ~/.aws-lambda-rie/aws-lambda-rie https://github.com/aws/aws-lambda-runtime-interface-emulator/releases/latest/download/aws-lambda-rie-arm64 && \
        chmod +x ~/.aws-lambda-rie/aws-lambda-rie
    ```

-   Run Docker Image

    ```sh
    docker run --platform linux/arm64 -d -v ~/.aws-lambda-rie:/aws-lambda -p 9000:8080 \
        --entrypoint /aws-lambda/aws-lambda-rie \
        lambda-image-02-non-aws-base:aws-tutorial \
            /usr/local/bin/python -m awslambdaric lambda_function.handler
    ```


### Build Image and Run Container on x86

-   Build Docker Image

    ```sh
    docker buildx build --platform linux/amd64 --provenance=false -t lambda-image-02-non-aws-base:aws-tutorial .
    ```

-   Install Runtime Interface Emulator locally

    ```sh
    mkdir -p ~/.aws-lambda-rie && \
        curl -Lo ~/.aws-lambda-rie/aws-lambda-rie https://github.com/aws/aws-lambda-runtime-interface-emulator/releases/latest/download/aws-lambda-rie && \
        chmod +x ~/.aws-lambda-rie/aws-lambda-rie
    ```

-   Run Docker Image

    ```sh
    docker run --platform linux/amd64 -d -v ~/.aws-lambda-rie:/aws-lambda -p 9000:8080 \
        --entrypoint /aws-lambda/aws-lambda-rie \
        lambda-image-02-non-aws-base:aws-tutorial \
            /usr/local/bin/python -m awslambdaric lambda_function.handler
    ```


## Submit Requests

-   Post event to the local endpoint

    ```sh
    curl "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{}'
    ```

-   Post event to the local endpoint with a JSON payload

    ```sh
    curl "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{"payload":"hello world!"}'
    ```
