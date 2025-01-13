#!/bin/bash

# Set script to exit on any error
set -e

# Configuration
IMAGE_NAME="potext-api-node"
CONTAINER_NAME="potext-api-node"
PORT="8080"

echo "=== AI Document API Node.js Docker Deployment ==="
echo "Image name: $IMAGE_NAME"
echo "Container name: $CONTAINER_NAME"
echo "Port mapping: $PORT:$PORT"

# Check if Docker is running
if ! docker info >/dev/null 2>&1; then
    echo "Error: Docker is not running. Please start Docker first."
    exit 1
fi

# Check if container already exists
if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "Warning: Container $CONTAINER_NAME already exists. Removing it..."
    docker rm -f $CONTAINER_NAME
fi

# Build Docker image
echo "=== Building Docker image... ==="
docker build -t $IMAGE_NAME . || {
    echo "Error: Failed to build Docker image"
    exit 1
}
echo "✓ Docker image built successfully"

# Run Docker container
echo "=== Starting Docker container... ==="
docker run -d \
    -p $PORT:$PORT \
    --name $CONTAINER_NAME \
    $IMAGE_NAME || {
    echo "Error: Failed to start Docker container"
    exit 1
}

# Verify container is running
if docker ps | grep -q $CONTAINER_NAME; then
    echo "✓ Container started successfully"
    echo "=== Container Details ==="
    docker ps | grep $CONTAINER_NAME
    docker logs -f $CONTAINER_NAME 
else
    echo "Error: Container failed to start"
    exit 1
fi