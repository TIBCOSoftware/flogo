---
title: Kubernetes
hidden: true
---

Kubernetes is probably the most wellknown container orchestration platform out there, with a ton of companies building and hosting their own specific version or making use of of one. In this demo you explore how to run Flogo apps on Kubernetes. The demo will walk you through deploying two apps:

* An **invoice service** which gets details on the invoice you specify in the URL
* A **payment service** which gets details on the expected payment date for the invoice (_The invoice service will make use of the payment service to display all data_)

## What you'll need

The demo needs a working Kubernetes cluster. If you haven't got one, setting one up using [minikube](https://github.com/kubernetes/minikube) is quite easy! You'll also need to have the Flogo CLI installed. If that is not the case, you might want to install them first. Our [Getting Started](../../getting-started/getting-started-cli/) guide walks you through the installation of Go, the Flogo CLI and Go Dep.

## Scripts

A fully scripted version of this tutorial is available in the [samples](https://github.com/TIBCOSoftware/flogo/tree/master/samples/kubernetes) directory as well! There are two different scenarios to deploy, one makes use of apps built using the Flogo Web UI and the other makes use of apps with the same functionality but built using the Go API.

The apps built with the Flogo Web UI are:

* [Invoice Service](https://github.com/retgits/flogo-components/tree/master/apps/invoiceservice)
* [Payment Service](https://github.com/retgits/flogo-components/tree/master/apps/paymentservice)

The apps built with the Go API are:

* [Invoice Service - Go](https://github.com/retgits/flogo-components/tree/master/apps/invoiceservice-go)
* [Payment Service - Go](https://github.com/retgits/flogo-components/tree/master/apps/paymentservice-go)

The shell script will allow you to choose between them, in this walk through you'll make use of the apps built with the Flogo Web UI. In the scenario you'll find a bunch of code blocks from which you can copy the code directly to your terminal. Please note that these commands are for MacOS and Linux, but should work on most Windows based systems as well.

## Getting the artifacts

The first step is to create a directory that will contain all the artifacts. For now we'll call that one `flogo-on-kubernetes`

```bash
# Set a root directory so that all commands start from the same directory
ROOTDIR=`pwd`
# Set a working directory for all the artifacts
WORKDIR=flogo-on-kubernetes
# Make sure the directory is cleanly created
rm -rf $ROOTDIR/$WORKDIR
mkdir -p $ROOTDIR/$WORKDIR
```

## Getting the Flogo apps

The demo will consist of two apps deployed to a Kubernetes cluster. We'll use docker images that already exist, but we do want to provide you with all the code and artifacts to show the apps in the Flogo Web UI. Let's start with downloading the apps

```bash
cd $ROOTDIR/$WORKDIR
curl -o invoiceservice.json https://raw.githubusercontent.com/retgits/flogo-components/master/apps/invoiceservice/invoiceservice.json
curl -o paymentservice.json https://raw.githubusercontent.com/retgits/flogo-components/master/apps/paymentservice/paymentservice.json
```

For each of the apps we'll need to run a command to create the app structure and download any dependencies

```bash
flogo create -f invoiceservice.json invoiceservice
flogo create -f paymentservice.json paymentservice
```

## Creating executables

Now, let's build the executables for the first app. We'll build two executables. One that will be able to run natively on your machine and one that will be a Linux executable to run in a docker container. So for the first app those commands are

```bash
cd $ROOTDIR/$WORKDIR/invoiceservice
env GOOS=linux flogo build -e
flogo build -e
```

For the second app they are

```bash
cd $ROOTDIR/$WORKDIR/paymentservice
env GOOS=linux flogo build -e
flogo build -e
```

## Dockerize all the things

Now on to Docker! We'll create docker images based on Alpine Linux. We'll put a Dockerfile in the `bin/linux_amd64` folder and run the command

```bash
# Set your Docker Hub username
DOCKERHUBUSER=my-name
# Go to the right directory
cd $ROOTDIR/$WORKDIR/invoiceservice/bin/linux_amd64
# Get a Dockerfile
curl -o Dockerfile https://raw.githubusercontent.com/retgits/flogo-components/master/apps/invoiceservice/Dockerfile
# Run the docker build command
docker build -t $DOCKERHUBUSER/invoiceservice .
```

And we'll do the same for the second service as well.

```bash
# Go to the right directory
cd $ROOTDIR/$WORKDIR/paymentservice/bin/linux_amd64
# Get a Dockerfile
curl -o Dockerfile https://raw.githubusercontent.com/retgits/flogo-components/master/apps/paymentservice/Dockerfile
# Run the docker build command
docker build -t $DOCKERHUBUSER/paymentservice .
```

## Running your Docker images

Right now you have two new docker images available in your registry, which you could use to test the whole scenario as well. If you want to do that run the below commands in separate terminal windows

```bash
docker run --rm -it -p 9998:8080 $DOCKERHUBUSER/paymentservice
docker run --rm -it -p 9999:8080 -e PAYMENTSERVICE=http://<YOUR IP>:9998/api/expected-date/:id $DOCKERHUBUSER/invoiceservice"
```

Now you can test the flow by running

```bash
# For the payment service
curl --request GET --url http://localhost:9998/api/expected-date/1234
# For the invoice service
curl --request GET --url http://localhost:9999/api/invoices/1234
```

For more information and sample messages check out the prebuilt docker images for these services on Docker Hub

* [invoiceservice](https://hub.docker.com/r/retgits/invoiceservice/)
* [paymentservice](https://hub.docker.com/r/retgits/paymentservice/)

Speaking of Docker Hub... you can push your docker containers to Docker Hub (assuming you have an account for it) by running

```bash
docker push $DOCKERHUBUSER/paymentservice:latest
docker push $DOCKERHUBUSER/invoiceservice:latest
```

## On to Kubernetes

The last step is to deploy to Kubernetes. To do that we need to download two additional files.

```bash
cd $ROOTDIR/$WORKDIR
curl -o invoice-svc.yml https://raw.githubusercontent.com/retgits/flogo-components/master/apps/invoiceservice/invoice-svc.yml
curl -o payment-svc.yml https://raw.githubusercontent.com/retgits/flogo-components/master/apps/paymentservice/payment-svc.yml
```

The payment-svc.yml file will create a deployment and a service resource in your Kubernetes cluster. For that we'll use an existing docker image called `retgits/paymentservice`, which is the same as the one you just built. If you want you can update the yaml file before running the below command.

```bash
kubectl apply -f payment-svc.yml
```

You now have a docker container that is accessible as a service on Kubernetes. The payment service is accessible on port 80 of the cluster IP address that was assigned to it. If you want to try it out look for the CLUSTER-IP of the payment-svc in the output from `kubectl get services`

```bash
kubectl run curl --image=radial/busyboxplus:curl -i --tty
```

This will start a new buxybox terminal in your cluster. From there you can run

```bash
curl <CLUSTERIP>/api/expected-date/3456
```

which should return something like `"{"expectedDate":"2018-02-26","id":"3456"}`

The second service we'll make available using the type: LoadBalancer which means that you can access it from outside your Kubernetes cluster. For this we'll use the existing container `retgits/invoiceservice`. If you open the invoice.yml file you'll see that there is an environment variable called PAYMENTSERVICE (line 24) which points to the DNS entry for the payment service. This way we can makes updates and potentially move the payment service around without having to update this service.

```bash
kubectl apply -f invoice-svc.yml
```

## Done

All done! You now have two Flogo apps running on a Kubernetes cluster which you invoke by sending a curl message to the Kubernetes IP address or localhost if you're running Docker for Mac. You can execute a command like:

```bash
curl localhost:80/api/invoices/1234
```

which will return something like `"{"amount":1162,"balance":718,"currency":"USD","expectedPaymentDate":"2018-03-02","id":"1234","ref":"INV-1234"}"`

Happy Kube-ing!!
