# Integrating uv with Docker

This folder demonstrates how to run a Docker image that is built from a 
Dockerfile which installed Python packages with `uv`


- What: Integrate `Dockerfile` with `uv`
  - https://docs.astral.sh/uv/guides/integration/docker/

- Why: Leverage the performance of `uv` to build `Dockerfile` images
- How:
  - Demonstrate how `uv` can be integrated with Docker https://docs.astral.sh/uv/guides/integration/docker/

## Changes from previous example
- Add generic `.dockerignore`
- Add generic `.gitignore`
- Add `Dockerfile`

## Building Docker Image and Running Docker Container

### Build Image and Run Container on macOS

-   Build Docker Image

    ```sh
    docker build -f Dockerfile -t python-image-02-uv-in-dockerfile .
    ```


-   Run Docker Image

    ```sh
    docker run python-image-02-uv-in-dockerfile
    ```

    and this should be printed to the console:

    ```text
    Hello World!
    ```
