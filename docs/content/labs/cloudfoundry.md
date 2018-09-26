---
title: "Cloud Deployments: Cloud Foundry"
hidden: true
---

[Cloud Foundry](https://cloudfoundry.org/) is an open-source platform as a service (PaaS) that provides you with a choice of clouds, developer frameworks, and application services.

## What you'll need

### Flogo CLI

This demo makes use of the Flogo CLI. If you don't have that one running yet, please check out [Getting Started with the Flogo CLI](../../getting-started/getting-started-cli/)

### Cloud Foundry

If you want to run Flogo apps in a Cloud Foundry environment, you have two options:

* Using the [binary buildpack](https://docs.cloudfoundry.org/buildpacks/binary/index.html)
* Using docker containers

{{% notice tip %}}
If you want to try out Pivotal Cloud Foundry, you might to check out [PCF Dev](https://pivotal.io/platform/pcf-tutorials/getting-started-with-pivotal-cloud-foundry-dev/introduction) and follow the first three steps to get your environment up and running.
{{% /notice %}}

## Using the binary buildpack

With the Cloud Foundry Binary Buildpack you can run arbitrary binary web servers on Cloud Foundry without the need to have a specific build pack for that language. Since Flogo can compile down to a binary, this saves you from installing additional buildpacks. There are a few prerequisites you need to take into account though:

* You'll need a binary that is able to run on the same OS as CF is deployed (most likely Linux, which you can do with `env GOOS=linux flogo build`)
* You'll need to make sure you're using port 8080 for your Receive HTTP Message trigger

Steps to deploy:

* Make sure the app is executable: `chmod +x <appname>`
* Push to PCF: `cf push <name in pcf> -c './<appname>' -b binary_buildpack`

For more detailed information and more flags you can set during deployments, check [Binary Buildpack](https://docs.cloudfoundry.org/buildpacks/binary/index.html) in the Cloud Foundry docs.

## Using docker

> By default, apps deployed with the cf push command run in standard Cloud Foundry Linux containers. With Docker support enabled, Cloud Foundry can also deploy and manage apps running in Docker containers.

To enable docker support an administrator has to run:

```bash
cf enable-feature-flag diego_docker
```

For example, the below command would push and run the Project Flogo Web UI on Cloud Foundry

```bash
cf push my-app --docker-image flogo/flogo-docker
```

For more detailed information and more flags you can set during deployments, check [Deploy an App with Docker](https://docs.cloudfoundry.org/devguide/deploy-apps/push-docker.html) in the Cloud Foundry docs.
