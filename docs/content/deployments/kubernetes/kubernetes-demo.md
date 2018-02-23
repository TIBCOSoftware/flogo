---
title: Kubernetes demo scenario
weight: 6050
---

This demo scneario will help you get up and running with a Flogo demo on Kubernetes. We'll assume you have the following tools installed already. If that is not the case, you might want to install them first.

* curl
* golang 1.9+
* go dep
* flogo
* docker
* kubectl

In the scenario you'll find a bunch of code blocks from which you can copy the code directly to your terminal. Please note that these commands are for MacOS and Linux, but should work on most Windows based systems as well.

A fully scripted version of this tutorial is available in our [samples](https://github.com/TIBCOSoftware/flogo/tree/master/samples/kubernetes) directory as well! The script will pause after every step explaining what it did.

## The scenario
Let's talk about the scenario first... Lets create a set of microservices which will manage invoices for a company. The idea was nicely explained on https://hackernoon.com/getting-started-with-microservices-and-kubernetes-76354312b556 using Node.js code, so we'll do it with Flogo and we'll create:

* A front end invoices service to return information about invoices
* A back end expected date service that’ll tell us when an invoice is likely to be paid

## Getting the artifacts
The first step is to create a directory that will have all the artifacts. For now we'll call that one `flogo-on-kubernetes`

```
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
```
cd $ROOTDIR/$WORKDIR
curl -o invoiceservice.json https://raw.githubusercontent.com/retgits/flogo-components/master/apps/invoiceservice/invoiceservice.json
curl -o paymentservice.json https://raw.githubusercontent.com/retgits/flogo-components/master/apps/paymentservice/paymentservice.json
```

For each of the apps we'll need to run a command to create the app structure and download any dependencies
```
flogo create -f invoiceservice.json invoiceservice
flogo create -f paymentservice.json paymentservice
```

## Creating executables
Now, let's build the executables for the first app. We'll build two executables. One that will be able to run natively on your machine and one that will be a Linux executable to run in a docker container. So for the first app those commands are
```
cd $ROOTDIR/$WORKDIR/invoiceservice
env GOOS=linux flogo build -e
flogo build -e
```

For the second app they are
```
cd $ROOTDIR/$WORKDIR/paymentservice
env GOOS=linux flogo build -e
flogo build -e
```

## Dockerize all the things
Now on to Docker! We'll create docker images based on Alpine Linux. We'll put a Dockerfile in the bin/linux_amd64 folder and run the command
```
# Set your Docker Hub username
DOCKERHUBUSER=my-name
# Go to the right directory
cd $ROOTDIR/$WORKDIR/invoiceservice/bin/linux_amd64
# Create a dockerfile
dockerfile="FROM alpine:latest
RUN apk update && apk add ca-certificates
ENV HTTPPORT=8080 \ 
    PAYMENTSERVICE=bla
ADD invoiceservice .
EXPOSE 8080
CMD ./invoiceservice"
echo "$dockerfile" > Dockerfile
# Run the docker build command
docker build -t $DOCKERHUBUSER/invoiceservice .
```

And we'll do the same for the second service as well."
```
# Go to the right directory
cd $ROOTDIR/$WORKDIR/paymentservice/bin/linux_amd64
# Create a dockerfile
dockerfile="FROM alpine:latest
RUN apk update && apk add ca-certificates
ENV HTTPPORT=8080
ADD paymentservice .
EXPOSE 8080
CMD ./paymentservice"
echo "$dockerfile" > Dockerfile
# Run the docker build command
docker build -t $DOCKERHUBUSER/paymentservice .
```

## Running your Docker images
Right now you have two new docker images available in your registry, which you could use to test the whole scenario as well. If you want to do that run the below commands in separate terminal windows
```
docker run --rm -it -p 9999:8080 $DOCKERHUBUSER/paymentservice
docker run --rm -it -p 9998:8080 -e PAYMENTSERVICE=http://<YOUR IP>:9999/api/expected-date/:id $DOCKERHUBUSER/invoiceservice"
```
For more information and sample messages check out the prebuilt docker images for these services on Docker Hub

* [invoiceservice](https://hub.docker.com/r/retgits/invoiceservice/)
* [paymentservice](https://hub.docker.com/r/retgits/paymentservice/)

Sidestepping here for a second... you can push your docker containers to Docker Hub (assuming you have an account for it) by running
```
docker push $DOCKERHUBUSER/paymentservice:latest
docker push $DOCKERHUBUSER/invoiceservice:latest
```

## On to Kubernetes!
The last step is to deploy to Kubernetes. To do that we need to download two additional files.
```
cd $ROOTDIR/$WORKDIR
curl -o invoice-svc.yml https://raw.githubusercontent.com/retgits/flogo-components/master/apps/kubefiles/invoice-svc.yml
curl -o payment-svc.yml https://raw.githubusercontent.com/retgits/flogo-components/master/apps/kubefiles/payment-svc.yml
```

The payment-svc.yml file will create a deployment and a service resource in your Kubernetes cluster. For that we'll use an existing docker image called `retgits/paymentservice`, which is the same as the one you just built. If you want you can update the yaml file before running the below command.
```
kubectl apply -f payment-svc.yml
```

You now have a docker container that is accessible as a service on Kubernetes. The payment service is accessible on port 80 of the cluster IP address that was assigned to it. If you want to try it out look for the CLUSTER-IP of the payment-svc in the output from `kubectl get services`
```
kubectl run curl --image=radial/busyboxplus:curl -i --tty
```
This will start a new buxybox terminal in your cluster. From there you can run 
```
curl <CLUSTERIP>/api/expected-date/3456
```
which should return something like `"{"expectedDate":"2018-02-26","id":"3456"}`

The second service we'll make available using the type: LoadBalancer which means that you can access it from outside your Kubernetes cluster. For this we'll use the existing container `retgits/invoiceservice`. If you open the invoice.yml file you'll see that there is an environment variable called PAYMENTSERVICE (line 24) which points to the DNS entry for the payment service. This way we can makes updates and potentially move the payment service around without having to update this service.
```
kubectl apply -f invoice-svc.yml
```

## Done!
All done! You now have two Flogo apps running on a Kubernetes cluster which you invoke by sending a curl message to the Kubernetes IP address or localhost if you're running Docker for Mac. You can execute a command like"
```
curl localhost:80/api/invoices/1234
```
which will return something like `"{"amount":1162,"balance":718,"currency":"USD","expectedPaymentDate":"2018-03-02","id":"1234","ref":"INV-1234"}"`

Happy Kube-ing!!