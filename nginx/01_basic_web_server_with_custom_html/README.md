# Running a basic web server

- What: Run a basic web server
- Why: Keeping in simple
- How: Based on this guide https://www.docker.com/blog/how-to-use-the-official-nginx-docker-image/


## Changes from previous example
- None


## Building Docker Image and Running Docker Container

This is almost verbatim from https://www.docker.com/blog/how-to-use-the-official-nginx-docker-image/
Copying the instructions because of the transient nature of URLs.

1.  Start a basic web server

    Let’s run a basic web server using the official NGINX image. Run the following command to start the container.

    ```sh
    docker run -it --rm -d -p 8080:80 --name web nginx
    ```

    With the above command, you started running the container as a daemon (-d) and published port 8080 on the host network. You also named the container web using the --name option.


2.  Open NGINX welcome page in a web browser.

    Open your favorite browser and navigate to http://localhost:8080   You should see the following NGINX welcome page.
    This is great but the purpose of running a web server is to serve our own custom html files and not the default NGINX welcome page.

3.  Stop the Docker container

    Let’s stop the container and take a look at serving our own HTML files.

    ```sh
    docker stop web
    ```


4.  Start the Docker container fiwt

    Now run the following command, which is the same command as above, but now we’ve added the -v flag to create a bind mount volume. This will mount our local directory ~/site-content locally into the running container at: /usr/share/nginx/html

    ```sh
    docker run -it --rm -d -p 8080:80 --name web -v ./site-content:/usr/share/nginx/html nginx
    ```


## Testing

Open your favorite browser and navigate to http://localhost:8080
