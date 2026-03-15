# Integrating uv with Dockerfile and docker compose

This folder demonstrates how to run a Docker image that is built from a 
Dockerfile which installed Python packages with `uv`


- What: Add `docker-compose.yaml` to start `Dockerfile` with `uv` 
  - https://docs.astral.sh/uv/guides/integration/docker/
- Why: Leverage the performance of `uv` to build `Dockerfile` images
- How:
  - Demonstrate how `uv` can be integrated with Docker https://docs.astral.sh/uv/guides/integration/docker/

## Changes from previous example
- Add `docker-compose.yaml`

## Building Docker Image and Running Docker Container with Docker Compose

### Build Image and Run Container on macOS

-   Build Docker Image

    ```sh
    docker compose up -d --build
    ```

-   Confirm in the Docker Container that it prints:

    >Hello World!
