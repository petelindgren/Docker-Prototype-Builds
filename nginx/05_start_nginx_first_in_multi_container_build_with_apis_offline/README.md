# Start nginx reverse proxy first in a multi-container build with Two API services

- What: Run a web server built from a custon nginx Dockerfile
- Why: Introduce custom Dockerfile to nginx build
- How: Based on these guides
  - https://www.docker.com/blog/how-to-use-the-official-nginx-docker-image/
  - https://dev.to/danielkun/nginx-everything-about-proxypass-2ona
  - https://geshan.com.np/blog/2024/03/nginx-docker-compose/


## Changes from previous example
- Update example number in `index.html`
- Start nginx first as reverse proxy even when not all upstream hosts are available
  - Update `docker-compose.yml` to start nginx first and then two API services by making
    both API services `depends_on` the `nginx_reverse_proxy`.
  - Update `nginx.conf` to `proxy_pass` to the `$upstream` for both API services.
    (see [Understanding Docker DNS](https://medium.com/@prajwal.chin/understanding-docker-dns-2ed4b070a0)

    >Docker daemon as the DNS server: Containers use the Docker daemon’s embedded DNS resolver, which listens on the default DNS server IP address 127.0.0.11. This DNS server handles DNS queries from containers and forwards them to the appropriate DNS server for resolution.


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
