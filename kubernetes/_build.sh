#!/bin/sh
set -e

export DOCKER_TAG=dev
docker build -t learninglocker2-app:$DOCKER_TAG ../app
docker tag learninglocker2-app:$DOCKER_TAG podiumnextunstable.azurecr.io/learninglocker2-app:$DOCKER_TAG
docker push podiumnextunstable.azurecr.io/learninglocker2-app:$DOCKER_TAG

docker build -t learninglocker2-nginx:$DOCKER_TAG ../nginx
docker tag learninglocker2-nginx:$DOCKER_TAG podiumnextunstable.azurecr.io/learninglocker2-nginx:$DOCKER_TAG
docker push podiumnextunstable.azurecr.io/learninglocker2-nginx:$DOCKER_TAG