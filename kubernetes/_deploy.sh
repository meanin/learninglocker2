kubectl apply -f namespace.yaml
kubectl apply -f secret.yaml

kubectl apply -f api-stateful.yaml
kubectl apply -f redis-deployment.yaml
kubectl apply -f ui-stateful.yaml
kubectl apply -f worker-stateful.yaml
kubectl apply -f xapi-deployment.yaml
