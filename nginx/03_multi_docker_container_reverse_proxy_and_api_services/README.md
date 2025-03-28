# Run a multi-container nginx reverse proxy with One API service

- What: Run a web server built from a custon nginx Dockerfile
- Why: Introduce custom Dockerfile to nginx build
- How: Based on these guides
  - https://www.docker.com/blog/how-to-use-the-official-nginx-docker-image/
  - https://dev.to/danielkun/nginx-everything-about-proxypass-2ona
  - https://geshan.com.np/blog/2024/03/nginx-docker-compose/


## Changes from previous example
- Update example number in `index.html`
- Add new code for FastAPI service
  - Add `Dockerfile.fastapi`
  - Add `main.py`
  - Add `requirements.txt`
- Update nginx so it is started as reverse proxy
  - Rename `Dockerfile` to `Dockerfile.nginx` (for clarity, not because it was required)
  - Remove `site-content` directory
  - Add `nginx.conf`
  - Update `docker-compose.yml`


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

2.  Test nginx reverse proxy forwards to the API server

    - http://127.0.0.1:8080/fastapi/ or http://localhost:8080/fastapi/

3.  Test nginx does not redirect as _intuitively_ expected when missing trailing slash `/` (see [Nginx: everything about proxy_pass](https://dev.to/danielkun/nginx-everything-about-proxypass-2ona))

    - http://127.0.0.1:8080/fastapi or http://localhost:8080/fastapi

4.  Demonstrate that the API services are port forwarded

    - http://127.0.0.1:9001/
    - http://127.0.0.1:9002/
