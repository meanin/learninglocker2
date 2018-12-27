#!/bin/sh

echo "creating namespace"
kubectl apply -f namespace.yaml

echo "deploying services"
kubectl apply -f redis.yaml
kubectl apply -f xapi.yaml
kubectl apply -f api.yaml
kubectl apply -f ui.yaml
kubectl apply -f worker.yaml

echo "creating ingress controller"
kubectl apply -f ingress.yaml

echo "done"
