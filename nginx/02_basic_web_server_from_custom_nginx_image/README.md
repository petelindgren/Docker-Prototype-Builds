# Running a web server from custom nginx image

- What: Run a web server built from a custon nginx Dockerfile
- Why: Introduce custom Dockerfile to nginx build
- How: Based on this guide https://www.docker.com/blog/how-to-use-the-official-nginx-docker-image/


## Changes from previous example
- Add `Dockerfile`
- Remove `site-content` directory


## Building Docker Image and Running Docker Container

This is almost verbatim from https://www.docker.com/blog/how-to-use-the-official-nginx-docker-image/
Copying the instructions because of the transient nature of URLs.

1.  Build Docker Image

    To build our image, run the following command:

    ```sh
    docker build -t webserver .
    ```

    The build command will tell Docker to execute the commands located in our Dockerfile.


2.  Run the Docker Image in a Container

    Now we can run our image in a container but this time we do not have to create a bind mount to include our html.

    ```sh
    docker run -it --rm -d -p 8080:80 --name web webserver
    ```


## Testing

Open your favorite browser and navigate to http://localhost:8080
