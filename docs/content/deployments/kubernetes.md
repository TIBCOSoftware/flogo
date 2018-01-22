---
title: Kubernetes
weight: 6040
---

[Kubernetes](https://kubernetes.io/) is an open-source system for automating deployment, scaling, and management of containerized applications. It groups containers that make up an application into logical units for easy management and discovery.

For this scenario to work you'll need to have access to a Kubernetes environment. If you haven’t set up your own Kubernetes cluster yet, you might want to look at [minikube](https://github.com/kubernetes/minikube). The team has made an amazing effort to make it super easy to run your own cluster locally with minimal installation effort. The [readme](https://github.com/kubernetes/minikube/blob/master/README.md) is an excellent place to get started, including installing your own Kubernetes cluster. In this scenario we'll use a few minikube commands:
* `minikube start` -> Start your minikube cluster
* `minikube ip` -> Get the public IP address of your cluster

_All commands are very well documented on the minikube repos_

## Deployment
The _Deployment_ in Kubernetes is a controller which provides declarative updates for Pods and ReplicaSets. Essentially speaking it gives you the ability to declaratively update your apps, meaning zero downtime!

A sample `deployment.yaml` file could like like below. This will create a Deployment on Kubernetes, with a single replica (so one instance of our app running) where the container will have the name `flogoapp` and it will pull the `<image name>` as the container to run. Pay special attention to the `containerPort` as that will make sure that the port will be accessible from the outside (though still within the cluster)

```yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: flogoapp-deployment
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: flogoapp
    spec:
      containers:
      - name: flogoapp
        image: <image name>
        imagePullPolicy: Always
        ports:
        - containerPort: 8080
```

To now create a deployment you can run
```
kubectl create -f deployment.yaml
```

Within the kubectl cli tool, or using the dashboard, you can see the status of your deployments:
```
$ kubectl get deployments
NAME DESIRED CURRENT UP-TO-DATE AVAILABLE AGE
flogoapp-deployment 1 1 1 1 50m
```

## Service
> Kubernetes Pods are mortal. They are born and when they die, they are not resurrected. ReplicationControllers in particular create and destroy Pods dynamically (e.g. when scaling up or down or when doing rolling updates). While each Pod gets its own IP address, even those IP addresses cannot be relied upon to be stable over time. This leads to a problem: if some set of Pods (let’s call them backends) provides functionality to other Pods (let’s call them frontends) inside the Kubernetes cluster, how do those frontends find out and keep track of which backends are in that set?
Source: [Kubernetes.io](https://kubernetes.io/docs/concepts/services-networking/service)

So the services logically group pods together and make sure that even when a pod goes away you don’t have to change IP addresses. A service can have a lot of different capabilities and many more configuration options, so let’s create one that is fairly simple.

The below `service.yaml` file simply defines the service `flogoapp` that directly binds port 8080 of the app we have deployed to port 30061 that we can access from outside of the cluster.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: flogoapp
  labels:
    app: flogoapp
spec:
  selector:
    app: flogoapp
  ports:
  - port: 8080
    protocol: TCP
    nodePort: 30061
  type: LoadBalancer
```

To create the service in Kubernetes you can simply run:
```
kubectl create -f service.yaml
```
Within the kubectl cli tool, or using the dashboard, you can see the status of your services just like your deployments:
```
$ kubectl get services
NAME TYPE CLUSTER-IP EXTERNAL-IP PORT(S) AGE
flogoapp LoadBalancer 10.0.0.110 <pending> 8989:30061/TCP 1h
kubernetes ClusterIP 10.0.0.1 <none> 443/TCP 1d
```

## Testing
Accessing the app is quite simple now as it is now accessible from the external IP address from the Kubernetes cluster. If you’re running minikube you can get that by running `minikube ip`. 