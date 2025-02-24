

References:
- https://docs.aws.amazon.com/lambda/latest/dg/python-image.html#python-image-instructions
- https://docs.aws.amazon.com/lambda/latest/dg/python-image.html#python-image-clients
- https://docs.aws.amazon.com/lambda/latest/dg/images-create.html#images-types



On macOS
```sh
docker buildx build --platform linux/arm64 --provenance=false -t docker-image:test .
```

```sh
mkdir -p ~/.aws-lambda-rie && \
    curl -Lo ~/.aws-lambda-rie/aws-lambda-rie https://github.com/aws/aws-lambda-runtime-interface-emulator/releases/latest/download/aws-lambda-rie-arm64 && \
    chmod +x ~/.aws-lambda-rie/aws-lambda-rie
```

```sh
docker run --platform linux/arm64 -d -v ~/.aws-lambda-rie:/aws-lambda -p 9000:8080 \
    --entrypoint /aws-lambda/aws-lambda-rie \
    docker-image:test \
        /usr/local/bin/python -m awslambdaric lambda_function.handler
```

```
curl "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{}'
```


```sh
docker buildx build --platform linux/amd64 --provenance=false -t docker-image:test .
```

```sh
mkdir -p ~/.aws-lambda-rie && \
    curl -Lo ~/.aws-lambda-rie/aws-lambda-rie https://github.com/aws/aws-lambda-runtime-interface-emulator/releases/latest/download/aws-lambda-rie && \
    chmod +x ~/.aws-lambda-rie/aws-lambda-rie
```

```sh
docker run --platform linux/amd64 -d -v ~/.aws-lambda-rie:/aws-lambda -p 9000:8080 \
    --entrypoint /aws-lambda/aws-lambda-rie \
    docker-image:test \
        /usr/local/bin/python -m awslambdaric lambda_function.handler
```