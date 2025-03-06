# Start multiple lambdas with Docker Compose

- What: Update app to support multiple lambdas
- Why: This brings together multiple facets.
- How:
  - Use a non-AWS base image for Python (see [Using an alternative base image with the runtime interface client](https://docs.aws.amazon.com/lambda/latest/dg/python-image.html#python-image-clients))
  - Dockerfile build installs:
    - [AWS Runtime Interface Emulator](https://github.com/aws/aws-lambda-runtime-interface-emulator/). (see [README.md instructions](https://github.com/aws/aws-lambda-runtime-interface-emulator/tree/v1.23?tab=readme-ov-file#build-rie-into-your-base-image))  
    - The Dockerfile uses a `CPU_TYPE` ARG so builds can use `x86_64` or `arm64` versions of the AWS Runtime Interface Emulator (see [ref](https://thelinuxcode.com/condition-in-dockerfile/))
    - `awslambdaric`
  - Introduces `docker-entrypoint.sh` for a future Dockerfile build that has multiple lambdas.
  - Use docker extension fields https://docs.docker.com/reference/compose-file/extension/

## Changes from previous example

- Update `Dockerfile`
  - replace `CMD [ "run_lambda" ]` with `CMD [ "start" ]` which will not have a match in the `docker-entrypoint.sh` case-switch lookup
- Update `docker-compose.yml` to start and stop container with docker compose v2
  - remove obsolete attribute `version`
  - add a `command` over-ride for each lambda and start each container on a different port
- Rename `lambda_function.py` to `lambda_function1.py`
- Create new `lambda_function2.py` as copy of `lambda_function1.py`


## Building Docker Image and Running Docker Container

### Build Dependencies
This repo has downloaded executables from https://github.com/aws/aws-lambda-runtime-interface-emulator/releases/tag/v1.23
- `aws-lambda-rie-arm64`
- `aws-lambda-rie-x86_64`


### Build Image and Run Application with Docker Compose

-   Start application with docker compose in detached mode

    ```sh
    docker compose up -d
    ```

-   Stop application with docker compose

    ```sh
    docker compose down
    ```


### Build Image and Run Container on macOS

-   Build Docker Image

    ```sh
    docker build -t multi-lambda-image-06-with-docker-compose:arm64 .
    ```

-   Run Docker Image

    ```sh
    docker run -p 9000:8080 multi-lambda-image-06-with-docker-compose:arm64
    ```


### Build Image and Run Container on x86

-   Build Docker Image

    ```sh
    docker build -t multi-lambda-image-06-with-docker-compose:x86_64 --build-arg CPU_TYPE=x86 .
    ```

-   Run Docker Image

    ```sh
    docker run -p 9000:8080 multi-lambda-image-06-with-docker-compose:x86_64
    ```


## Submit Requests

-   Post event to the local endpoint for Lambda 1

    ```sh
    curl "http://localhost:9001/2015-03-31/functions/function/invocations" -d '{}'
    ```

-   Post event to the local endpoint for Lambda 2

    ```sh
    curl "http://localhost:9002/2015-03-31/functions/function/invocations" -d '{}'
    ```
