#!/bin/bash

# Description: Provisioning script for Flogo on Kubernetes demo
# Author: Leon Stigter <lstigter@gmail.com>
# Last Updated: 2018-02-21

# UPDATE THE VARIABLES BELOW
# The root directory to download all artifacts to. It defaults to the current working
#   directory, but you can change it if you want
ROOTDIR=`pwd`
DOCKERHUBUSER=retgits

# DO NOT MODIFY BELOW THIS LINE
## Variables
WORKDIR=flogo-on-kubernetes

clear
echo "********************************************************************************"
echo "* Flogo on Kubernetes Demo Script                                              *"
echo "********************************************************************************"

echo ""
echo "This script will help you set up a Flogo demo on Kubernetes and will pause after"
echo "each step, explaining what has happened. After the script has paused you'll see"
echo "[ENTER], meaning you can hit the enter key to continue."
read -p "If you're ready to get started hit [ENTER] now!"

echo ""
echo "Okay, awesome! We'll assume you have the following tools installed already. If"
echo "that is not the case, you might want to hit ctrl+c now and install them first"
echo " - curl"
echo " - golang 1.9+"
echo " - go dep"
echo " - flogo"
echo " - docker"
echo " - kubectl"
read -p "[ENTER]"

echo ""
echo "Let's talk about the scenario first..."
echo "Lets create a set of microservices which will manage invoices for a company."
echo "The idea was nicely explained on https://hackernoon.com/getting-started-with-microservices-and-kubernetes-76354312b556"
echo "using Node.js code, so we'll do it with Flogo and we'll create:"
echo " - A front end invoices service to return information about invoices"
echo " - A back end expected date service that’ll tell us when an invoice is likely to be paid"
read -p "[ENTER]"

rm -rf $ROOTDIR/$WORKDIR
mkdir -p $ROOTDIR/$WORKDIR
echo ""
echo "We've just created a directory called $WORKDIR which we'll use to"
echo "download all artifacts in"
read -p "[ENTER]"

cd $ROOTDIR/$WORKDIR
echo ""
curl -o invoiceservice.json https://raw.githubusercontent.com/retgits/flogo-components/master/apps/invoiceservice/invoiceservice.json
curl -o paymentservice.json https://raw.githubusercontent.com/retgits/flogo-components/master/apps/paymentservice/paymentservice.json
echo ""
echo "The demo will consist of two apps deployed to a Kubernetes cluster. We'll use"
echo "docker images that already exist, but we do want to provide you with all the"
echo "code and artifacts to show the apps in the Flogo Web UI. To do so, we just"
echo "downloaded the two JSON files that represent the Flogo apps"
echo " - invoiceservice.json"
echo " - paymentservice.json"

read -p "[ENTER]"

echo ""
echo "Now we'll create the Flogo app for the invoice service"
echo "to do so, we're running the command"
echo "flogo create -f invoiceservice.json invoiceservice"
read -p "[ENTER]"
flogo create -f invoiceservice.json invoiceservice

echo ""
echo "Great! The first app is done, now on to the second one."
echo "For that one we'll run"
echo "flogo create -f paymentservice.json paymentservice"
read -p "[ENTER]"
flogo create -f paymentservice.json paymentservice

echo ""
echo "Now, let's build the executables for the first app."
echo "We'll build two executables. One that will be able to run natively"
echo "on your machine and one that will be a Linux executable to run in a"
echo "docker container. To do so we'll execute:"
echo "flogo build -e"
echo "env GOOS=linux flogo build -e"
read -p "[ENTER]"
cd $ROOTDIR/$WORKDIR/invoiceservice
env GOOS=linux flogo build -e
flogo build -e

echo ""
echo "One down and one to go! We'll do the same thing for the second service."
echo "Again we'll execute:"
echo "flogo build -e"
echo "env GOOS=linux flogo build -e"
read -p "[ENTER]"
cd $ROOTDIR/$WORKDIR/paymentservice
env GOOS=linux flogo build -e
flogo build -e

echo ""
echo "Now on to Docker! We'll create docker images based on Alpine Linux."
echo "We'll put a Dockerfile in the bin/linux_amd64 folder and run the command"
echo "docker build -t $DOCKERHUBUSER/invoiceservice ."
read -p "[ENTER]"
cd $ROOTDIR/$WORKDIR/invoiceservice/bin/linux_amd64
dockerfile="FROM alpine:latest
RUN apk update && apk add ca-certificates
ENV HTTPPORT=8080 \ 
    PAYMENTSERVICE=bla
ADD invoiceservice .
EXPOSE 8080
CMD ./invoiceservice"
echo "$dockerfile" > Dockerfile
docker build -t $DOCKERHUBUSER/invoiceservice .

echo ""
echo "And we'll do the same for the second service as well."
echo "We'll put a Dockerfile in the bin/linux_amd64 folder and run the command"
echo "docker build -t $DOCKERHUBUSER/paymentservice ."
read -p "[ENTER]"
cd $ROOTDIR/$WORKDIR/paymentservice/bin/linux_amd64
dockerfile="FROM alpine:latest
RUN apk update && apk add ca-certificates
ENV HTTPPORT=8080
ADD paymentservice .
EXPOSE 8080
CMD ./paymentservice"
echo "$dockerfile" > Dockerfile
docker build -t $DOCKERHUBUSER/paymentservice .

echo ""
echo "Right now you have two new docker images available in your registry, which you"
echo "could use to test the whole scenario as well. If you want to do that run the"
echo "below commands in separate terminal windows"
echo "docker run --rm -it -p 9999:8080 $DOCKERHUBUSER/paymentservice"
echo "docker run --rm -it -p 9998:8080 -e PAYMENTSERVICE=http://<YOUR IP>:9999/api/expected-date/:id $DOCKERHUBUSER/invoiceservice"
echo ""
echo "for more information and sample messages check out"
echo "invoiceservice: https://hub.docker.com/r/retgits/invoiceservice/"
echo "paymentservice: https://hub.docker.com/r/retgits/paymentservice/"
read -p "[ENTER]"

echo ""
echo "Sidestep... you can push your docker containers to Docker Hub (assuming you"
echo "have an account for it) by running"
echo "docker push $DOCKERHUBUSER/paymentservice:latest"
echo "docker push $DOCKERHUBUSER/invoiceservice:latest"

echo ""
echo "The last step is to deploy to Kubernetes. To do that we need to download two"
echo "additional files."
read -p "[ENTER]"
cd $ROOTDIR/$WORKDIR
curl -o invoice-svc.yml https://raw.githubusercontent.com/retgits/flogo-components/master/apps/kubefiles/invoice-svc.yml
curl -o payment-svc.yml https://raw.githubusercontent.com/retgits/flogo-components/master/apps/kubefiles/payment-svc.yml

echo ""
echo "The payment-svc.yml file will create a deployment and a service resource"
echo "in your Kubernetes cluster. For that we'll use an existing docker image called"
echo "retgits/paymentservice, which is the same as the one you just built. If you want"
echo "you can update the yaml file before pressing a key..."
read -p "[ENTER]"
kubectl apply -f payment-svc.yml

echo ""
echo "You now have a docker container that is accessible as a service on Kubernetes"
echo "The payment service is accessible on port 80 of the cluster IP address"
echo "that was assigned to it. If you want to try it out look for the CLUSTER-IP"
echo "of the payment-svc in the output below"
kubectl get services
echo "and run kubectl run curl --image=radial/busyboxplus:curl -i --tty"
echo "which will start a new buxybox terminal in your cluster. From there you can"
echo "run curl <CLUSTERIP>/api/expected-date/3456 which should return something like"
echo "{\"expectedDate\":\"2018-02-26\",\"id\":\"3456\"}"
read -p "[ENTER]"

echo ""
echo "The second service we'll make available using the type: LoadBalancer which means"
echo "that you can access it from outside your Kubernetes cluster. For this we'll use"
echo "the existing container retgits/invoiceservice. If you open the invoice.yml file"
echo "you'll see that there is an environment variable called PAYMENTSERVICE (line 24)"
echo "which points to the DNS entry for the payment service. This way we can makes"
echo "updates and potentially move the payment service around without having to update"
echo "this service."
read -p "[ENTER]"
kubectl apply -f invoice-svc.yml

echo ""
echo "All done! You now have two Flogo apps running on a Kubernetes cluster which you"
echo "invoke by sending a curl message to the Kubernetes IP address or localhost if"
echo "you're running Docker for Mac. You can execute a command like"
echo "curl localhost:80/api/invoices/1234 which will return something like"
echo "{\"amount\":1162,\"balance\":718,\"currency\":\"USD\",\"expectedPaymentDate\":\"2018-03-02\",\"id\":\"1234\",\"ref\":\"INV-1234\"}"
echo ""
echo "Happy Kube-ing!!"