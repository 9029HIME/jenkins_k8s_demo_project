#!/bin/bash
IMAGE_NAME=harbor.genn.com/cloud_01/cloud-stock
containerId=`docker ps -a | grep "$IMAGE_NAME" | awk '{print $1}'`
imageId=`docker images | grep "$IMAGE_NAME" | awk '{print $3}'`
echo "containerId=$containerId,imageId=$imageId"

docker stop $containerId
docker rm $containerId
docker rmi $imageId
cp ../target/*.jar ../dockerfiles
docker build -t $IMAGE_NAME ../dockerfiles/
docker run -d --network=host -p 9001:9001 -e "STOCK_META=10086" --add-host=kjg-pc:192.168.120.161 $IMAGE_NAME --name=test-stock-env
docker push $IMAGE_NAME