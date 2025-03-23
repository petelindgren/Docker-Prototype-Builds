# Define custom function directory
ARG FUNCTION_DIR="/app"
ARG CPU_TYPE

FROM python:3.12 AS build-image

# Include global arg in this stage of the build
ARG FUNCTION_DIR
ARG CPU_TYPE

# Follow instructions for installing 'aws-lambda-runtime-interface-emulator'...
#   See https://github.com/aws/aws-lambda-runtime-interface-emulator/tree/v1.23?tab=readme-ov-file#build-rie-into-your-base-image
# ...but use the build time variable `CPU_TYPE` to install RIE for x86_64 or default arm64
RUN apt-get install wget
RUN if [ "$CPU_TYPE" == "x86" ]; \
    then \
        wget -0 /usr/local/bin/aws-lambda-rie https://github.com/aws/aws-lambda-runtime-interface-emulator/releases/download/v1.23/aws-lambda-rie; \
    else \
        wget -O /usr/local/bin/aws-lambda-rie https://github.com/aws/aws-lambda-runtime-interface-emulator/releases/download/v1.23/aws-lambda-rie-arm64; \
    fi
RUN chmod +x /usr/local/bin/aws-lambda-rie

# Copy function code
RUN mkdir -p ${FUNCTION_DIR}
COPY . ${FUNCTION_DIR}

# Install the function's dependencies
RUN pip install \
    --target ${FUNCTION_DIR} \
        awslambdaric

# Use a slim version of the base Python image to reduce the final image size
FROM python:3.12-slim

# Include global arg in this stage of the build
ARG FUNCTION_DIR
# Set working directory to function root directory
WORKDIR ${FUNCTION_DIR}

# Copy in the built dependencies
COPY --from=build-image ${FUNCTION_DIR} ${FUNCTION_DIR}
COPY --from=build-image /usr/local/bin/aws-lambda-rie /usr/local/bin/aws-lambda-rie

# Combine RUN commands to reduce layers in final image
RUN mv docker-entrypoint.sh /usr/local/bin && \
    chmod +x /usr/local/bin/docker-entrypoint.sh

# Set runtime interface client as default command for the container runtime
ENTRYPOINT [ "docker-entrypoint.sh" ]

# Pass the name of the function handler as an argument to the runtime
CMD [ "start" ]
