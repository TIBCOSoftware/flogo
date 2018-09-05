#!/usr/bin/env bash

# Description: Demo script to help deploy Flogo apps to Kubernetes
# Author: retgits <https://github.com/retgits>
# Last Updated: 2018-08-14

#--- Variables ---
# These are the variables you want to update. 
# The root directory to download all artifacts to. It defaults to the current working directory, but you can change it if you want
ROOTDIR=`pwd`
# The docker hub echo is used to connect to Docker Hub and push images so a Kubernetes instance will be able to download the images
DOCKERHUBUSER=retgits

#--- Start of the script ---
# You do not want to modify below this line, unless you really want to obviously :)

#--- Variables ---
VERSION=0.1.0
WORKDIR=flogo-on-kubernetes
GOPTH="$(go env GOPATH)"

#--- Function to print the header ---
header () {
    clear
    echo "********************************************************************************"
    echo "* Flogo on Kubernetes Demo Script                                              *"
    echo "*                                                               Version: $VERSION *"
    echo "********************************************************************************"
    echo ""
}

#--- Function to validate the prerequisites ---
validate () {
    header
    echo "Checking cURL"
    curl --version

    echo ""
    echo "Checking Go"
    go version

    echo ""
    echo "Checking dep"
    dep version
    
    echo ""
    echo "Checking Flogo"
    flogo version
    
    echo ""
    echo "Checking docker"
    docker version --format "{{.Client.Version}}"
    
    echo ""
    echo "Checking kubectl"
    kubectl version
}

#--- Start of each scenario ---
start_scenario () {
    header
    echo "Kubernetes is probably the most wellknown container orchestration platform out"
    echo "there, with a ton of companies building and hosting their own specific version"
    echo "or making use of of one. In this demo you explore how to run Flogo apps on" 
    echo "Kubernetes. The demo will walk you through deploying two apps:"
    echo ""
    echo "* An invoice service which gets details on the invoice you specify in the URL"
    echo "* A payment service which gets details on the expected payment date for the"
    echo "  invoice"
    echo ""
    echo "The invoice service will make use of the payment service to display all data"
    echo ""
    echo "This script will walk you through depoying Flogo apps to Kubernetes and will"
    echo "pause after each step, explaining what has happened. After the script has "
    echo "paused you'll see [ENTER], meaning you can hit the enter key to continue."
    echo "If you're ready to get started hit [ENTER] now!"
    read -p ""
}

#--- Function to deploy the flow based apps to Kubernetes ---
deploy_flows () {
    start_scenario

    rm -rf $ROOTDIR/$WORKDIR
    mkdir -p $ROOTDIR/$WORKDIR
    echo "A new directory called \"$WORKDIR\" has just been created and that"
    echo "will be used to download all artifacts in"
    echo "[ENTER]"
    read -p ""

    cd $ROOTDIR/$WORKDIR
    curl -o invoiceservice.json https://raw.githubusercontent.com/retgits/flogo-components/master/apps/invoiceservice/invoiceservice.json
    curl -o paymentservice.json https://raw.githubusercontent.com/retgits/flogo-components/master/apps/paymentservice/paymentservice.json
    echo ""
    echo "As mentioned earlier, the demo will deploy two apps to your Kubernetes" 
    echo "cluster. You can use docker images that already exist on Docker Hub (which is"
    echo "the default) or you'll be provided with the opportunity to use your own. To "
    echo "do that this script will also download a bunch of files. The first two, that" 
    echo "were just downloaded, are the flogo.json files for the apps in case you want"
    echo "to see them in the Flogo Web UI. The downloaded files are:"
    echo " - invoiceservice.json"
    echo " - paymentservice.json"
    echo "[ENTER]"
    read -p ""

    echo "To create the actual Flogo app for the invoice service you'll need to run"
    echo "flogo create -f invoiceservice.json invoiceservice"
    echo "[ENTER]"
    read -p ""
    flogo create -f invoiceservice.json invoiceservice

    echo ""
    echo "Great! The first app is done, now on to the second one."
    echo "For that one you'll run"
    echo "flogo create -f paymentservice.json paymentservice"
    echo "[ENTER]"
    read -p ""
    flogo create -f paymentservice.json paymentservice

    echo ""
    echo "The dependencies and all the code for the apps has been downloaded. The next "
    echo "step is to build the executables for the two apps. You'll start by building "
    echo "the executable for the invoice service app, and you'll actually build two "
    echo "executables. One that will be able to run natively on your machine and one"
    echo "that will be a Linux executable to run in a docker container. To do so you'll" 
    echo "need to run:"
    echo "\"flogo build -e\" to create the executable that runs on your machine and "
    echo "\"env GOOS=linux CGO_ENABLED=0 flogo build -e\" for the executable in the docker container"
    echo "[ENTER]"
    read -p ""
    cd $ROOTDIR/$WORKDIR/invoiceservice
    env GOOS=linux CGO_ENABLED=0 flogo build -e
    flogo build -e

    echo ""
    echo "One down and one to go! For the payment service you'll need to do the same "
    echo "thing, running"
    echo "\"flogo build -e\" to create the executable that runs on your machine and "
    echo "\"env GOOS=linux CGO_ENABLED=0 flogo build -e\" for the executable in the docker container"
    echo "[ENTER]"
    read -p ""
    cd $ROOTDIR/$WORKDIR/paymentservice
    env GOOS=linux CGO_ENABLED=0 flogo build -e
    flogo build -e

    echo ""
    echo "Now on to Docker! To minimize deployment footprint you'll create docker "
    echo "images based on Alpine Linux. From there you can download the Dockerfile"
    echo "and execute"
    echo "docker build -t $DOCKERHUBUSER/invoiceservice ."
    echo "[ENTER]"
    read -p ""

    if [ -d "$ROOTDIR/$WORKDIR/invoiceservice/bin/linux_amd64" ]; then
        SOURCEDIR=$ROOTDIR/$WORKDIR/invoiceservice/bin/linux_amd64
    else
        SOURCEDIR=$ROOTDIR/$WORKDIR/invoiceservice/bin
    fi
    
    cd $SOURCEDIR
    curl -o Dockerfile https://raw.githubusercontent.com/retgits/flogo-components/master/apps/invoiceservice/Dockerfile
    docker build -t $DOCKERHUBUSER/invoiceservice .

    echo ""
    echo "And you can do the same for the second service as well."
    echo "docker build -t $DOCKERHUBUSER/paymentservice ."
    echo "[ENTER]"
    read -p ""

    if [ -d "$ROOTDIR/$WORKDIR/paymentservice/bin/linux_amd64" ]; then
        SOURCEDIR=$ROOTDIR/$WORKDIR/paymentservice/bin/linux_amd64
    else
        SOURCEDIR=$ROOTDIR/$WORKDIR/paymentservice/bin
    fi
    
    cd $SOURCEDIR
    curl -o Dockerfile https://raw.githubusercontent.com/retgits/flogo-components/master/apps/paymentservice/Dockerfile
    docker build -t $DOCKERHUBUSER/paymentservice .

    echo ""
    echo "Right now you have two new docker images available in your registry, which"
    echo "you could use to test the whole scenario as well. If you want to do that "
    echo "run the below commands in separate terminal windows"
    echo "docker run --rm -it -p 9999:8080 $DOCKERHUBUSER/paymentservice"
    echo "docker run --rm -it -p 9998:8080 -e PAYMENTSERVICE=http://<YOUR IP>:9999/api/expected-date/:id $DOCKERHUBUSER/invoiceservice"
    echo ""
    echo "for more information and sample messages check out"
    echo "invoiceservice: https://hub.docker.com/r/retgits/invoiceservice/"
    echo "paymentservice: https://hub.docker.com/r/retgits/paymentservice/"
    echo "[ENTER]"
    read -p ""

    echo ""
    echo "Sidestep... you can push your docker containers to Docker Hub (assuming you"
    echo "have an account for it) by running"
    echo "docker push $DOCKERHUBUSER/paymentservice:latest"
    echo "docker push $DOCKERHUBUSER/invoiceservice:latest"
    echo "[ENTER]"
    read -p ""

    echo ""
    echo "The last step is to deploy to Kubernetes. To do that you will need to download"
    echo "two additional files."
    echo "[ENTER]"
    read -p ""
    cd $ROOTDIR/$WORKDIR
    curl -o invoice-svc.yml https://raw.githubusercontent.com/retgits/flogo-components/master/apps/kubefiles/invoice-svc.yml
    curl -o payment-svc.yml https://raw.githubusercontent.com/retgits/flogo-components/master/apps/kubefiles/payment-svc.yml

    echo ""
    echo "The payment-svc.yml file will create a deployment and a service resource"
    echo "in your Kubernetes cluster. For that you'll use an existing docker image"
    echo "called retgits/paymentservice, which is the same as the one you just"
    echo " built. If you want you can update the yaml file before pressing a key..."
    echo "[ENTER]"
    read -p ""
    kubectl apply -f payment-svc.yml

    echo ""
    echo "You now have a docker container that is accessible as a service on"
    echo "Kubernetes. The payment service is accessible on port 80 of the cluster"
    echo "IP address that was assigned to it. If you want to try it out look for the"
    echo "CLUSTER-IP of the payment-svc in the output below"
    kubectl get services
    echo "and run kubectl run curl --image=radial/busyboxplus:curl -i --tty"
    echo "which will start a new buxybox terminal in your cluster. From there you can"
    echo "run curl <CLUSTERIP>/api/expected-date/3456 which should return something like"
    echo "{\"expectedDate\":\"2018-02-26\",\"id\":\"3456\"}"
    echo "[ENTER]"
    read -p ""

    echo ""
    echo "The second service is one you'll make available using the type: LoadBalancer"
    echo "which means that you can access it from outside your Kubernetes cluster. For"
    echo "this you'll use the existing container retgits/invoiceservice. If you open "
    echo "the invoice.yml file you'll see that there is an environment variable called"
    echo " PAYMENTSERVICE (line 24) which points to the DNS entry for the payment"
    echo "service. This way you can make updates and potentially move the service "
    echo "around without having to update the invoice service."
    echo "[ENTER]"
    read -p ""
    kubectl apply -f invoice-svc.yml

    echo ""
    echo "All done! You now have two Flogo apps running on a Kubernetes cluster which"
    echo "you invoke by sending a curl message to the Kubernetes IP address or "
    echo "localhost if you're running Docker for Mac. You can execute a command like"
    echo "curl `minikube service invoice-svc --url`/api/invoices/1234 which will return something like"
    echo "{\"amount\":1162,\"balance\":718,\"currency\":\"USD\",\"expectedPaymentDate\":\"2018-03-02\",\"id\":\"1234\",\"ref\":\"INV-1234\"}"
    echo ""
    success "Happy Kube-ing!!"
}

#--- Function to clean up the flow based apps ---
cleanup_flows () {
    header
    echo "This script will help you tear down the apps deployed using \"deploy-flows\""
    echo "If you're not ready to continue, press ctrl+c otherwise press [ENTER] to" 
    echo "remove the apps"
    read -p ""
    kubectl delete deployments,services -l run=payment-svc
    kubectl delete deployments,services -l run=invoice-svc
}

#--- Function to deploy the Go based apps to Kubernetes ---
deploy_golang () {
    start_scenario

    go get -d https://github.com/retgits/flogo-components
    echo "We've just downloaded the code to \"$GOPTH/src/github.com/retgits/flogo-components/apps\"."
    echo "In there, among a ton of other things, are the two apps that we'll use to" 
    echo "build and deploy to Kubernetes"
    echo "[ENTER]"
    read -p ""

    echo ""
    echo "As mentioned earlier, the demo will deploy two apps to your Kubernetes" 
    echo "cluster. The two apps are built using the Go API for Flogo and you can"
    echo "use docker images that already exist on Docker Hub (which is the default)"
    echo "or you'll be provided with the opportunity to use your own."
    echo "[ENTER]"
    read -p ""

    echo ""
    echo "The first step is to download all the dependencies the apps. The next "
    echo "step is to generate the Flogo metadata (required by Flogo) and build the"
    echo "executables for the two apps. You'll start by building "
    echo "the executable for the invoice service app. To do so you'll" 
    echo "need to run:"
    echo "\"go get -u ./...\" to download all the dependencies"
    echo "\"go generate\" to generate the metadata for Flogo"
    echo "\"env GOOS=linux CGO_ENABLED=0 go build\" for the executable in the docker container"
    echo "[ENTER]"
    read -p ""
    cd $GOPTH/src/github.com/retgits/flogo-components/apps/invoiceservice-go
    go get -u ./...
    go generate
    GOOS=linux CGO_ENABLED=0 go build

    echo ""
    echo "One down and one to go! For the payment service you'll need to do the same "
    echo "thing, running"
    echo "\"go get -u ./...\" to download all the dependencies"
    echo "\"go generate\" to generate the metadata for Flogo"
    echo "\"env GOOS=linux CGO_ENABLED=0 go build\" for the executable in the docker container"
    echo "[ENTER]"
    read -p ""
    cd $GOPTH/src/github.com/retgits/flogo-components/apps/paymentservice-go
    go get -u ./...
    go generate
    GOOS=linux go build

    echo ""
    echo "Now on to Docker! To minimize deployment footprint you'll create docker "
    echo "images based on Alpine Linux. From there you can download the Dockerfile"
    echo "and execute"
    echo "docker build -t $DOCKERHUBUSER/invoiceservice-go ."
    echo "[ENTER]"
    read -p ""

    cd $GOPTH/src/github.com/retgits/flogo-components/apps/invoiceservice-go
    curl -o Dockerfile https://raw.githubusercontent.com/retgits/flogo-components/master/apps/invoiceservice-go/Dockerfile
    docker build -t $DOCKERHUBUSER/invoiceservice-go .

    echo ""
    echo "And you can do the same for the second service as well."
    echo "docker build -t $DOCKERHUBUSER/paymentservice-go ."
    echo "[ENTER]"
    read -p ""
    cd $GOPTH/src/github.com/retgits/flogo-components/apps/paymentservice-go
    curl -o Dockerfile https://raw.githubusercontent.com/retgits/flogo-components/master/apps/paymentservice-go/Dockerfile
    docker build -t $DOCKERHUBUSER/paymentservice-go .

    echo ""
    echo "Right now you have two new docker images available in your registry, which"
    echo "you could use to test the whole scenario as well. If you want to do that "
    echo "run the below commands in separate terminal windows"
    echo "docker run --rm -it -p 9999:8080 $DOCKERHUBUSER/-go"
    echo "docker run --rm -it -p 9998:8080 -e PAYMENTSERVICE=http://<YOUR IP>:9999/api/expected-date/ $DOCKERHUBUSER/invoiceservice-go"
    echo ""
    echo "for more information and sample messages check out"
    echo "invoiceservice: https://hub.docker.com/r/retgits/invoiceservice-go/"
    echo "paymentservice: https://hub.docker.com/r/retgits/paymentservice-go/"
    echo "[ENTER]"
    read -p ""

    echo ""
    echo "Sidestep... you can push your docker containers to Docker Hub (assuming you"
    echo "have an account for it) by running"
    echo "docker push $DOCKERHUBUSER/paymentservice-go:latest"
    echo "docker push $DOCKERHUBUSER/invoiceservice-go:latest"
    echo "[ENTER]"
    read -p ""

    echo ""
    echo "The last step is to deploy to Kubernetes. To do that you will need to download"
    echo "two additional files."
    echo "[ENTER]"
    read -p ""
    curl -o $GOPTH/src/github.com/retgits/flogo-components/apps/invoiceservice-go/invoice-go-svc.yml https://raw.githubusercontent.com/retgits/flogo-components/master/apps/kubefiles/invoice-go-svc.yml
    curl -o $GOPTH/src/github.com/retgits/flogo-components/apps/paymentservice-go/payment-go-svc.yml https://raw.githubusercontent.com/retgits/flogo-components/master/apps/kubefiles/payment-go-svc.yml

    echo ""
    echo "The payment-go-svc.yml file will create a deployment and a service resource"
    echo "in your Kubernetes cluster. For that you'll use an existing docker image"
    echo "called retgits/paymentservice, which is the same as the one you just"
    echo " built. If you want you can update the yaml file before pressing a key..."
    echo "[ENTER]"
    read -p ""
    cd $GOPTH/src/github.com/retgits/flogo-components/apps/paymentservice-go
    kubectl apply -f payment-go-svc.yml

    echo ""
    echo "You now have a docker container that is accessible as a service on"
    echo "Kubernetes. The payment service is accessible on port 80 of the cluster"
    echo "IP address that was assigned to it. If you want to try it out look for the"
    echo "CLUSTER-IP of the payment-svc in the output below"
    kubectl get services
    echo "and run kubectl run curl --image=radial/busyboxplus:curl -i --tty"
    echo "which will start a new buxybox terminal in your cluster. From there you can"
    echo "run curl <CLUSTERIP>/api/expected-date/3456 which should return something like"
    echo "{\"expectedDate\":\"2018-02-26\",\"id\":\"3456\"}"
    echo "[ENTER]"
    read -p ""

    echo ""
    echo "The second service is one you'll make available using the type: LoadBalancer"
    echo "which means that you can access it from outside your Kubernetes cluster. For"
    echo "this you'll use the existing container retgits/invoiceservice. If you open "
    echo "the invoice.yml file you'll see that there is an environment variable called"
    echo " PAYMENTSERVICE (line 24) which points to the DNS entry for the payment"
    echo "service. This way you can make updates and potentially move the service "
    echo "around without having to update the invoice service."
    echo "[ENTER]"
    read -p ""
    cd $GOPTH/src/github.com/retgits/flogo-components/apps/invoiceservice-go
    kubectl apply -f invoice-go-svc.yml

    echo ""
    echo "All done! You now have two Flogo apps running on a Kubernetes cluster which"
    echo "you invoke by sending a curl message to the Kubernetes IP address or "
    echo "localhost if you're running Docker for Mac. You can execute a command like"
    echo "curl `minikube service invoice-go-svc --url`/api/invoices/1234 which will return something like"
    echo "{\"amount\":1162,\"balance\":718,\"currency\":\"USD\",\"expectedPaymentDate\":\"2018-03-02\",\"id\":\"1234\",\"ref\":\"INV-1234\"}"
    echo ""
    success "Happy Kube-ing!!"
}

#--- Function to clean up the Go based apps ---
cleanup_golang () {
    header
    echo "This script will help you tear down the apps deployed using \"deploy-golang\""
    echo "If you're not ready to continue, press ctrl+c otherwise press [ENTER] to" 
    echo "remove the apps"
    read -p ""
    kubectl delete deployments,services -l run=payment-go-svc
    kubectl delete deployments,services -l run=invoice-go-svc
}

case "$1" in 
    "deploy-flows")
        deploy_flows
        ;;
    "cleanup-flows")
        cleanup_flows
        ;;
    "deploy-golang")
        deploy_golang
        ;;
    "cleanup-golang")
        cleanup_golang
        ;;
    "validate")
        validate
        ;;
    *)
        echo "The target {$1} you want to execute doesn't exist"
        echo ""
        echo "Usage:"
        echo "./`basename "$0"` [target]"
        echo ""
        echo "Possible targets are"
        echo "  deploy-flows  : Deploy the apps that were created using the Flogo Web UI to Kubernetes"
        echo "  cleanup-flows : Remove the apps and services created using the deploy-flows option"
        echo "  deploy-golang : Deploy the apps that were created using Flogo as a lib to Kubernetes"
        echo "  cleanup-golang: Remove the apps and services created using the deploy-golang option"
        echo "  validate      : Checks if the prerequisites for this script are met"
esac