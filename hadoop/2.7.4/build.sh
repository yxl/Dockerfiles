#!/bin/bash

TAG=yuanxulei/hadoop:2.7.4

docker build --tag $TAG . || exit 1
docker login || exit 2
docker push $TAG || exit 3
