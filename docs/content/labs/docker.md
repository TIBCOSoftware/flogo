---
title: "Cloud Deployments: Docker"
hidden: true
---

Flogo apps are _ultralight_ so building docker images is not only really easy, because it can embed all dependencies it can also run inside of super small docker containers.

## What you'll need

### Flogo CLI

This demo makes use of the Flogo CLI. If you don't have that one running yet, please check out [Getting Started with the Flogo CLI](../../getting-started/getting-started-cli/)

## Using flogo

Out of the box, Flogo has the option to build a docker container from the app.

```bash
flogo build -e -docker <trigger id>
```

The above command will build a Flogo app, with embedded configuration (`-e`), and create a docker image where it can expose the PORT based on which trigger ID you specify. If you don't want to expose a port (for example, because you start with a timer) you can specify `no-trigger` as the trigger id.

The docker file it generates and uses to build the docker image is:

```bash
# Dockerfile for {{.name}}
# VERSION {{.version}}
FROM alpine
RUN apk update && apk add ca-certificates
ADD {{.name}}-linux-amd64 .
EXPOSE {{.port}}
CMD ./{{.name}}-linux-amd64`
```

{{% notice tip %}}
note that {{.name}} and {{.port}} are substitution variables coming from the configuration of your app
{{% /notice %}}

After building the image you can run the container using the `docker run` command

## Do-It-Yourself

While practical, you don't have to rely on `flogo` to generate the docker image for you. If you prefer to construct the **Dockerfile** yourself, that is perfectly okay too. The flogo cli simply wraps the command:

```bash
docker build . -t <app name>:<app version>
```
