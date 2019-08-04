#!/bin/bash
TAG=yuanxulei/confluence-server:6.15-mysql

docker build --tag $TAG . || exit 1
docker login || exit 2
docker push $TAG || exit 3
