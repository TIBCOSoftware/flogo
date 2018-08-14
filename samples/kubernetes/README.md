# Flogo on Kubernetes

This script accompanies the Kubernetes tutorial in our [docs](https://tibcosoftware.github.io/flogo/deployments/kubernetes/kubernetes-demo/)

## Get started
To get started, run `./flogo-on-kubernetes.sh [target]`

Possible targets are
* deploy-flows  : Deploy the apps that were created using the Flogo Web UI to Kubernetes
* cleanup-flows : Remove the apps and services created using the deploy-flows option
* deploy-golang : Deploy the apps that were created using the Flogo Go API to Kubernetes
* cleanup-golang: Remove the apps and services created using the deploy-golang option
* validate      : Checks if the prerequisites for this script are met