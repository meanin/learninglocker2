# Learning Locker version 2 in Kubernetes

It is a dockerized version of Learning Locker (LL) version 2 based on the installation guides at http://docs.learninglocker.net/guides-custom-installation/

## Architecture

For LL's architecture consult http://docs.learninglocker.net/overview-architecture/

This section is about the architecture coming out of this dockerization.

Official images of Mongo, Redis, and xAPI service are used.
Additionally, build creates two Docker images: nginx and app. 
LL application services are to be run on containers based on the app image. 

File docker-compose.yml describes the relation between services. 
A base configuration consists of 7 containers that are run using the above-mentioned images 
(LL application containers - api, ui, and worker - are run using image app).

The only persistent locations are directories, 
which are mounted as volumes to Mongo container and app-based containers.

The origin service ui expects service api to work on localhost, 
however in this dockerized version the both services are run in separate containers. 
To make connections between those services work, socat process is run within ui container to forward local tcp connections to api container.

## Usage

To build the images:

```
../build-dev.sh
```

Publish images to yours container registry
```
docker tag up2university/learninglocker2-app:$DOCKER_TAG $YOUR_CONTAINER_REGISTRY/learninglocker2-app:$DOCKER_TAG
docker push $YOUR_CONTAINER_REGISTRY/learninglocker2-app:$DOCKER_TAG
```

To create a new user and organisation for the site:

```
kubectl exec api-0 -n ll2 -- node cli/dist/server createSiteAdmin [email] [organisation] [password]
```


### Deployment

Preparing a remote machine for the first time, put check all environments variables in all yaml files. If you did not have a working mongo db instance, you can also create it as a statefullset with mounted disk.

Prerequisites for Learning Locker 2 is running kuberetes cluster. For instance in this example it is configured to use [AKS](https://docs.microsoft.com/en-us/azure/aks/) on an Azure Cloud. For an ingress controller (a way to get into running instance of LL2) it is needed to provide a public IP to an load balancer service. It can be done by following:
```
https://docs.microsoft.com/en-us/azure/aks/kubernetes-helm
https://docs.microsoft.com/en-us/azure/aks/ingress-basic
helm install stable/nginx-ingress --namespace kube-system --set rbac.create=false
kubectl get service -l app=nginx-ingress --namespace kube-system
```

Deployment script will push all pods (containers) into the cluser. To get to the LL2 check the nginx-ingress service public ip address and open the browser with pasted address.

To configure adjust env settings in yaml files:
* api.yaml
* ui.yaml
* worker.yaml
* xapi.yaml

To deploy services:
```
deploy.sh
```
