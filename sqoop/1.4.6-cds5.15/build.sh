#!/bin/bash

TAG=yuanxulei/sqoop:1.4.6-hive1-1.1.0-cdh5.15.0	

docker build --tag $TAG . || exit 1
docker login || exit 2
docker push $TAG || exit 3
