# Start multiple lambdas with Docker behind nginx reverse proxy service

- What: Add nginx reverse proxy service in front of multiple lambdas
- Why: Use nginx reverse proxy to route traffic from web browser to each lambda container
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
- Update `docker-compose.yml` to start and stop container with docker compose v2
- Add copy of files example `nginx/05_start_nginx_first_in_multi_container_build_with_apis_offline`
  - `Dockerfile.nginx`
  - `index.html`
  - `nginx.conf`
  - The `nginx_reverse_proxy` service from `docker-compose.yml`
- Update `docker-compose.yml`
  - Change `nginx_reverse_proxy` port forwarding from `"8080:80"` to `"8000:80"`
  - Change the networks for the lambdas
- Update `nginx.conf`
  - change the redirect `$upstream` to be compatible with AWS lambdas
  - handle the `-d '{}'` part of the `curl ... -d '{}'` command by rewriting the API request method from GET to POST.


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
    docker build -t multi-lambda-image-07-with-docker-compose:arm64 .
    ```

-   Run Docker Image

    ```sh
    docker run -p 9000:8080 multi-lambda-image-07-with-docker-compose:arm64
    ```


### Build Image and Run Container on x86

-   Build Docker Image

    ```sh
    docker build -t multi-lambda-image-07-with-docker-compose:x86_64 --build-arg CPU_TYPE=x86 .
    ```

-   Run Docker Image

    ```sh
    docker run -p 9000:8080 multi-lambda-image-07-with-docker-compose:x86_64
    ```


## Submit Requests from Terminal Window
This section reproduces the lambda calls from the AWS lambda tutorials.

-   Post event to the local endpoint for Lambda 1

    ```sh
    curl "http://localhost:9001/2015-03-31/functions/function/invocations" -d '{}'
    ```

-   Post event to the local endpoint for Lambda 2

    ```sh
    curl "http://localhost:9002/2015-03-31/functions/function/invocations" -d '{}'
    ```


## Submit Requests from nginx Docker Container
This section demonstrates how to re-create lambda calls from the AWS lambda tutorials within the nginx Docker container.

-   Open Docker Desktop and the **nginx** container (it might be named `nginx-reverse-proxy07`)

-   Go to the `Exec` tab

-   Post event to the local endpoint for Lambda 1

    ```sh
    curl "http://lambda1:8080/2015-03-31/functions/function/invocations" -d '{}'
    ```

-   Post event to the local endpoint for Lambda 2

    ```sh
    curl "http://lambda2:8080/2015-03-31/functions/function/invocations" -d '{}'
    ```

- Confirm that the response in the **nginx** container matches the response from the Terminal Window


## Submit Requests to a web browser
This section demonstrates how to re-create lambda calls from the AWS lambda tutorials within the nginx Docker container.

-   Open any web browser

-   Submit this URL for lambda1: http://localhost:8000/lambda1/

-   Submit this URL for lambda2: http://localhost:8000/lambda2/

    ```sh
    curl "http://lambda2:8080/2015-03-31/functions/function/invocations" -d '{}'
    ```

- Confirm that the response in the Web Browser matches the response from the Terminal Window and the **nginx** container
