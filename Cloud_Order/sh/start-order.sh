#!/bin/bash
IMAGE_NAME=harbor.genn.com/cloud_01/cloud-order
containerId=`docker ps -a | grep "$IMAGE_NAME" | awk '{print $1}'`
imageId=`docker images | grep "$IMAGE_NAME" | awk '{print $3}'`
echo "containerId=$containerId,imageId=$imageId"

docker stop $containerId
docker rm $containerId
docker rmi $imageId
cp ../target/*.jar ../dockerfiles
docker build -t $IMAGE_NAME ../dockerfiles/
docker run -d --network=host -p 8001:8001 -e "ORDER_META=this is order meta" --add-host=kjg-pc:192.168.120.161 $IMAGE_NAME --name=test-order-env
docker push $IMAGE_NAME