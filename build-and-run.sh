#!/bin/bash

# Script to build and run the Salary API Docker container

IMAGE_NAME="salary-api"
CONTAINER_NAME="salary-api-service"
CONTAINER_PORT=8081
HOST_PORT=8082

# Stop and remove any existing container with the same name to avoid conflicts
echo "Cleaning up old containers..."
docker stop $CONTAINER_NAME 2>/dev/null
docker rm $CONTAINER_NAME 2>/dev/null

echo "Building Docker image: $IMAGE_NAME"
docker build -t $IMAGE_NAME .

if [ $? -eq 0 ]; then
    echo "Build successful. Running container in DETACHED mode on host port $HOST_PORT..."
    # -d: detach, -p: port mapping, --name: specific name, --rm: auto-clean
    docker run -d -p $HOST_PORT:$CONTAINER_PORT --name $CONTAINER_NAME $IMAGE_NAME
    
    echo "------------------------------------------------"
    echo "Container is running!"
    echo "Use 'docker logs -f $CONTAINER_NAME' to view logs."
    echo "Use 'docker ps' to see running containers."
else
    echo "Build failed. Please check the Dockerfile and try again."
    exit 1
fi
