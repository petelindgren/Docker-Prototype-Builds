# Using a non-AWS base image for Python, but use docker-entrypoint.sh

This folder **_modifies_** a direct copy of the AWS documentation for
[Using an alternative base image with the runtime interface client](https://docs.aws.amazon.com/lambda/latest/dg/python-image.html#python-image-clients)

It introduces a new `docker-entrypoint.sh` and updates the `Dockerfile`

replacing old code block calling `lambda_function.handler` directly
```
# Set runtime interface client as default command for the container runtime
ENTRYPOINT [ "/usr/local/bin/python", "-m", "awslambdaric" ]
# Pass the name of the function handler as an argument to the runtime
CMD [ "lambda_function.handler" ]
```

with new code block that can accept a `CMD` over-ride
```
RUN mv docker-entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Set runtime interface client as default command for the container runtime
ENTRYPOINT [ "docker-entrypoint.sh" ]
# Pass the name of the function handler as an argument to the runtime
CMD [ "run_lambda" ]
```


References
- To make the image compatible with Lambda, you must include a [runtime interface client]() for your language in the image.


## Build Docker Image and Run Docker Container

### Build Image and Run Container on macOS

-   Build Docker Image

    ```sh
    docker buildx build --platform linux/arm64 --provenance=false -t lambda-image-03-non-aws-base:docker-entrypoint .
    ```

-   Install Runtime Interface Emulator

    ```sh
    mkdir -p ~/.aws-lambda-rie && \
        curl -Lo ~/.aws-lambda-rie/aws-lambda-rie https://github.com/aws/aws-lambda-runtime-interface-emulator/releases/latest/download/aws-lambda-rie-arm64 && \
        chmod +x ~/.aws-lambda-rie/aws-lambda-rie
    ```

-   Run Docker Image

    ```sh
    docker run --platform linux/arm64 -d -v ~/.aws-lambda-rie:/aws-lambda -p 9000:8080 \
        --entrypoint /aws-lambda/aws-lambda-rie \
        lambda-image-03-non-aws-base:docker-entrypoint \
            docker-entrypoint.sh run_lambda
    ```


### Build Image and Run Container on x86

-   Build Docker Image

    ```sh
    docker buildx build --platform linux/amd64 --provenance=false -t lambda-image-03-non-aws-base:docker-entrypoint .
    ```

-   Install Runtime Interface Emulator

    ```sh
    mkdir -p ~/.aws-lambda-rie && \
        curl -Lo ~/.aws-lambda-rie/aws-lambda-rie https://github.com/aws/aws-lambda-runtime-interface-emulator/releases/latest/download/aws-lambda-rie && \
        chmod +x ~/.aws-lambda-rie/aws-lambda-rie
    ```

-   Run Docker Image

    ```sh
    docker run --platform linux/amd64 -d -v ~/.aws-lambda-rie:/aws-lambda -p 9000:8080 \
        --entrypoint /aws-lambda/aws-lambda-rie \
        lambda-image-03-non-aws-base:docker-entrypoint \
            docker-entrypoint.sh run_lambda
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
