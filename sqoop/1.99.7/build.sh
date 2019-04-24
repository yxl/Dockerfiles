#!/bin/bash

TAG=yuanxulei/sqoop:1.99.7

docker build --tag $TAG . || exit 1
docker login || exit 2
docker push $TAG || exit 3
