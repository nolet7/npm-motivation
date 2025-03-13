#!/bin/bash
echo "Building Docker image with timestamp version..."

DOCKER_IMAGE="noletengine/npm-motivation"
BUILD_DATE=$(date +'%Y.%m.%d-%H%M')  # Example: 2025.03.13-2309

echo "Generated version: $BUILD_DATE"

docker build -t $DOCKER_IMAGE:latest .
docker tag $DOCKER_IMAGE:latest $DOCKER_IMAGE:$BUILD_DATE

# Save the tag version for later use
echo "BUILD_DATE=$BUILD_DATE" > build_version.env

