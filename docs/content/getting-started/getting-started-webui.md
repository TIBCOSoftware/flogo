---
date: 2016-04-09T16:50:16+02:00
title: Getting started with the Web UI
weight: 20
---


In this document we’ll discuss how to download the Flogo Web UI, a zero-code development environment for IoT and microservices.

## Prerequisites

Ensure that the following prerequisites have been fulfilled.

### Docker
Docker is required to pull the Web UI, as it is publicly available via hub.docker.com. If you're running Windows 10, Linux or macOS/OSX then the latest version of Docker should be installed and can be found at the link below.

https://www.docker.com/

If you're running a Windows machine and have anything older than Windows 10, then you must install the legacy Docker Toolbox, which can be found at the link below.

https://docs.docker.com/toolbox/toolbox_install_windows/

## Installing Flogo Web UI
Installing Flogo Web UI is quite simple and requires nothing more than Docker pre-installed on your machine to fetch the Docker image.

### Fetching and Starting Flogo Web UI
Execute the following command.

```docker run -it -p 3303:3303 flogo/flogo-docker:latest eula-accept```

If you don’t already have the Docker Image on your machine, Docker will pull the image from our publicly available DockerHub repo (https://hub.docker.com/r/flogo/flogo-docker).

The input parameters are:

* -p 3303:3303: This argument tells docker to bind the local port, 3303 to the container port, 3303.
* flogo/flogo-docker:latest: The repo, image name and the specific tag to pull. If you’d like to pull a specific version, you can replace ‘latest’ with the specific version. Check the available tags on the DockerHub repo.
* eula-accept: This argument just states that you’ve accepted the license agreement.

You should see something similar to the following output in your terminal/console window indicating that the image is up and the webui is running and available.

![Docker Container Started](../../images/start-docker-webui.png)

### Launching Flogo WebUI
To launch Flogo WebUI simply open your favorite web browser, and navigate to http://localhost:3303. You should be presented with the WebUI welcome page, as shown below.

![Web UI](../../images/webui-landing.png)

## Restarting the Web UI docker container
After the Docker container has been shutdown, you may wish to simply restart the same container instance, rather than creating a new instance via the `docker run` command. You can easily do this by issuing the `docker start` command and reference the previously running container id. You can find the container name and id by using the command `docker ps -a` and searching for the container with the image flogo/flogo-docker. Use the ID (or name) associated with the image to issue the `docker start` command. For example:

```docker start b24e4b9f3fa5```