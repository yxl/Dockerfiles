#!/bin/bash

TAG=yuanxulei/sqoop:1.4.7-hive-2.3.4

docker build --tag $TAG . || exit 1
docker login || exit 2
docker push $TAG || exit 3
