# Refactor Dockerfile image build

- What: Refactor previous example to support multiple lambda functions.
- Why: This creates the building blocks to add more lambda functions.
- How:
  - Use a non-AWS base image for Python (see [Using an alternative base image with the runtime interface client](https://docs.aws.amazon.com/lambda/latest/dg/python-image.html#python-image-clients))
  - Dockerfile build installs:
    - [AWS Runtime Interface Emulator](https://github.com/aws/aws-lambda-runtime-interface-emulator/). (see [README.md instructions](https://github.com/aws/aws-lambda-runtime-interface-emulator/tree/v1.23?tab=readme-ov-file#build-rie-into-your-base-image))  
    - The Dockerfile uses a `CPU_TYPE` ARG so builds can use `x86_64` or `arm64` versions of the AWS Runtime Interface Emulator (see [ref](https://thelinuxcode.com/condition-in-dockerfile/))
    - `awslambdaric`
  - Introduces `docker-entrypoint.sh` for a future Dockerfile build that has multiple lambdas.

## Changes from previous example

- Update `Dockerfile`
  - Change `ARG FUNCTION_DIR="/function"` to `ARG FUNCTION_DIR="/app"`
  - Use `ENTRYPOINT` to replace `entry_script.sh` with new `docker-entrypoint.sh`
- Add new `docker-entrypoint.sh` which incorporates business logic in `entry_script.sh` in a new `set_aws_lambda_runtime()` shell script function.
- Update `lambda_function.py` to return a JSON response.
  - Add `"uses_docker_compose": False`


## Building Docker Image and Running Docker Container

### Build Dependencies
This repo has downloaded executables from https://github.com/aws/aws-lambda-runtime-interface-emulator/releases/tag/v1.23
- `aws-lambda-rie-arm64`
- `aws-lambda-rie-x86_64`


### Build Image and Run Container on macOS

-   Build Docker Image

    ```sh
    docker build -t lambda-image-04-non-aws-base-with-rie:arm64 .
    ```

-   Run Docker Image

    ```sh
    docker run -p 9000:8080 lambda-image-04-non-aws-base-with-rie:arm64
    ```


### Build Image and Run Container on x86

-   Build Docker Image

    ```sh
    docker build -t lambda-image-04-non-aws-base-with-rie:x86_64 --build-arg CPU_TYPE=x86 .
    ```

-   Run Docker Image

    ```sh
    docker run -p 9000:8080 lambda-image-04-non-aws-base-with-rie:x86_64
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
