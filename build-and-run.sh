#!/bin/bash

# Script to build and run the Salary API Docker container

IMAGE_NAME="salary-api"
CONTAINER_PORT=8081
HOST_PORT=8082

echo "Building Docker image: $IMAGE_NAME"
docker build -t $IMAGE_NAME .

if [ $? -eq 0 ]; then
    echo "Build successful. Running container on host port $HOST_PORT..."
    docker run -p $HOST_PORT:$CONTAINER_PORT $IMAGE_NAME
else
    echo "Build failed. Please check the Dockerfile and try again."
    exit 1
fi
