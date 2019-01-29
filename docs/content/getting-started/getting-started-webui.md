---
title: Flogo Web UI
weight: 2020
pre: "<i class=\"fas fa-desktop\" aria-hidden=\"true\"></i> "
---

### Getting Started
For an overview of how to get started, check out the [Quickstart](../quickstart) guide

### Installing the Project Flogo Web UI
Installing the Project Flogo Web UI is quite simple and requires nothing more than Docker pre-installed on your machine to fetch the Docker image.

### Fetching and starting the Web UI
To get started with the latest version of the Flogo Web UI paste this command in a terminal window:

```docker run -it -p 3303:3303 flogo/flogo-docker:latest eula-accept```

### Launching the Web UI
To launch Flogo WebUI simply open your favorite web browser, and navigate to http://localhost:3303. You'll see our mascot Flynn there to greet you!

![Web UI](../../images/labs/helloworld/step1b.png)


### Restarting the Web UI docker container
After the Docker container has been shutdown, you may wish to simply restart the same container instance, rather than creating a new instance via the `docker run` command. You can easily do this by issuing the `docker start` command and reference the previously running container id. You can find the container name and id by using the command `docker ps -a` and searching for the container with the image flogo/flogo-docker. Use the ID (or name) associated with the image to issue the `docker start` command. For example:

```docker start b24e4b9f3fa5```