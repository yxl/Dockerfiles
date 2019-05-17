#!/bin/bash

TAG=yuanxulei/hadoop:cdh5.15.0

docker build --tag $TAG . || exit 1
docker login || exit 2
docker push $TAG || exit 3
