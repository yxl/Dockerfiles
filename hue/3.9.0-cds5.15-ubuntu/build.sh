#!/bin/bash

TAG=yuanxulei/hue:3.9.0-sqoop1.4.6-hive1.1.0-cdh5.15.0-ubuntu

docker build --tag $TAG . || exit 1
docker login || exit 2
docker push $TAG || exit 3
