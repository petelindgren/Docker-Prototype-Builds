# Using an AWS base image for Python

This folder is a direct copy of the AWS documentation for
[Using an AWS base image for Python](https://docs.aws.amazon.com/lambda/latest/dg/python-image.html#python-image-instructions)


## Build Docker Image and Run Docker Container

### Build Image and Run Container on macOS

-   Build Docker Image

    ```sh
    docker buildx build --platform linux/arm64 --provenance=false -t lambda-image-01-aws-base:aws-tutorial .
    ```


-   Run Docker Image

    ```sh
    docker run --platform linux/arm64 -p 9000:8080 lambda-image-01-aws-base:aws-tutorial
    ```


### Build Image and Run Container on x86

-   Build Docker Image

    ```sh
    docker buildx build --platform linux/amd64 --provenance=false -t lambda-image-01-aws-base:aws-tutorial .
    ```

-   Run Docker Image

    ```sh
    docker run --platform linux/amd64 -p 9000:8080 lambda-image-01-aws-base:aws-tutorial
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
