# Run a multi-container nginx reverse proxy with Two API services

- What: Run a web server built from a custon nginx Dockerfile
- Why: Introduce custom Dockerfile to nginx build
- How: Based on these guides
  - https://www.docker.com/blog/how-to-use-the-official-nginx-docker-image/
  - https://dev.to/danielkun/nginx-everything-about-proxypass-2ona
  - https://geshan.com.np/blog/2024/03/nginx-docker-compose/


## Changes from previous example
- Update example number in `index.html`
- Update existing code for FastAPI service1
  - Rename `Dockerfile.fastapi` to `Dockerfile.fastapi1`
  - Rename `main.py` to `main1.py`
- Add new code for FastAPI service2
  - Copy `Dockerfile.fastapi1` to `Dockerfile.fastapi2`
  - Copy `main1.py` to `main2.py`
- Update nginx so it is started as reverse proxy
  - Update `nginx.conf` with `proxy_pass` configuration for two API services
  - Update `docker-compose.yml` to start two API services


## Building Docker Images and Start Containers


1.  Start multi-container docker build in detached mode by running the following command:

    ```sh
    docker compose up -d --build
    ```


2.  Stop multi-container docker build in detached mode by running the following command:

    ```sh
    docker compose down
    ```

    This will leave the Docker images that were built


## Testing

Use your favorite browser.

1.  Test nginx static page: http://127.0.0.1:8080/

2.  Test nginx reverse proxy forwards to the API services

    - http://127.0.0.1:8080/fastapi1/ or http://localhost:8080/fastapi1/
    - http://127.0.0.1:8080/fastapi2/ or http://localhost:8080/fastapi2/

3.  Test nginx does not redirect as _intuitively_ expected when missing trailing slash `/` (see [Nginx: everything about proxy_pass](https://dev.to/danielkun/nginx-everything-about-proxypass-2ona))

    - http://127.0.0.1:8080/fastapi1 or http://localhost:8080/fastapi1
    - http://127.0.0.1:8080/fastapi2 or http://localhost:8080/fastapi2

4.  Demonstrate that the API services are port forwarded

    - http://127.0.0.1:9001/
    - http://127.0.0.1:9002/
