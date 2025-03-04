# Using a non-AWS base image for Python with AWS Runtime Interface Emulator installed by Docker

This folder is a direct copy of the AWS documentation for
[Using an alternative base image with the runtime interface client](https://docs.aws.amazon.com/lambda/latest/dg/python-image.html#python-image-clients).
- The [AWS Runtime Interface Emulator](https://github.com/aws/aws-lambda-runtime-interface-emulator/) is built into the Dockerfile image following this [README.md](https://github.com/aws/aws-lambda-runtime-interface-emulator/tree/v1.23?tab=readme-ov-file#build-rie-into-your-base-image).
- The Dockerfile also uses a `CPU_TYPE` ARG so builds can be `x86_64` or `arm64` (see [ref](https://thelinuxcode.com/condition-in-dockerfile/))


## Build Docker Image and Run Docker Container

### Build Dependencies
This repo has downloaded executables from https://github.com/aws/aws-lambda-runtime-interface-emulator/releases/tag/v1.23
- `aws-lambda-rie-arm64`
- `aws-lambda-rie-x86_64`


### Build Image and Run Container on macOS

-   Build Docker Image

    ```sh
    docker build -t lambda-image-03-non-aws-base-with-rie:arm64 .
    ```

-   Run Docker Image

    ```sh
    docker run -p 9000:8080 lambda-image-03-non-aws-base-with-rie:arm64
    ```


### Build Image and Run Container on x86

-   Build Docker Image

    ```sh
    docker build -t lambda-image-03-non-aws-base-with-rie:x86_64 --build-arg CPU_TYPE=x86 .
    ```

-   Run Docker Image

    ```sh
    docker run -p 9000:8080 lambda-image-03-non-aws-base-with-rie:x86_64
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
