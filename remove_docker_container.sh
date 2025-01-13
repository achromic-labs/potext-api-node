#!/bin/bash

# AI Document API Docker Container Management Script
# ===============================================
#
# Purpose:
#   Safely stops and removes the Docker container for the AI Document API Node.js service
#   to ensure clean environment for new deployments or testing
#
# Usage:
#   ./remove_docker_container.sh
#
# Prerequisites:
#   - Docker installed and running (docker --version)
#   - Sufficient permissions to execute Docker commands
#   - Execute permission on this script (chmod +x remove_docker.sh)
#
# Operations:
#   1. Checks if Docker is running
#   2. Checks if container 'potext-api-node' exists
#   3. If exists:
#      - Stops the running container
#      - Removes the container completely
#   4. Provides status updates throughout the process
#
# Note: 
#   - This script only removes containers, not Docker images
#   - Container name: potext-api-node

# Text colors for better visibility
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo "Starting Docker container cleanup process..."

# Check if Docker is running
if ! docker info >/dev/null 2>&1; then
    echo -e "${RED}Error: Docker is not running${NC}"
    exit 1
fi

# Check if the container exists
CONTAINER_NAME="potext-api-node"
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    echo -e "${GREEN}Found container: $CONTAINER_NAME${NC}"
    
    # Stop container
    echo "Stopping container..."
    if docker stop $CONTAINER_NAME; then
        echo -e "${GREEN}Container stopped successfully${NC}"
    else
        echo -e "${RED}Failed to stop container${NC}"
        exit 1
    fi
    
    # Remove container
    echo "Removing container..."
    if docker rm $CONTAINER_NAME; then
        echo -e "${GREEN}Container removed successfully${NC}"
    else
        echo -e "${RED}Failed to remove container${NC}"
        exit 1
    fi
else
    echo "No container found with name: $CONTAINER_NAME"
fi

echo -e "${GREEN}Cleanup process completed successfully${NC}"