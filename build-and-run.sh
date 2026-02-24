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
    
    # -d: detach
    # -p: host_port:container_port
    # -e SERVER_ADDRESS=0.0.0.0 -> Forces Spring to listen on all interfaces
    # -e SERVER_PORT=8081 -> Forces Spring to use the port your Dockerfile EXPOSEs
    docker run -d \
      -p $HOST_PORT:$CONTAINER_PORT \
      --name $CONTAINER_NAME \
      -e SERVER_ADDRESS=0.0.0.0 \
      -e SERVER_PORT=$CONTAINER_PORT \
      $IMAGE_NAME
    
    echo "------------------------------------------------"
    echo "Container is running!"
    echo "Checking logs for startup confirmation..."
    sleep 3 # Give it a moment to start
    docker logs $CONTAINER_NAME | grep "Started" || echo "App is starting, check logs with: docker logs -f $CONTAINER_NAME"
    echo "------------------------------------------------"
    echo "Test locally with: curl -v http://localhost:$HOST_PORT/api/budget"
else
    echo "Build failed. Please check the Dockerfile and try again."
    exit 1
fi