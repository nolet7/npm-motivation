#!/bin/bash
echo "Pushing Docker image to DockerHub with versioning..."

DOCKER_IMAGE="noletengine/npm-motivation"

# Load version from build
if [ -f "build_version.env" ]; then
    source build_version.env
else
    echo "❌ Error: build_version.env not found! Run build_docker.sh first."
    exit 1
fi

echo "Using version: $BUILD_DATE"

echo "${DOCKERHUB_PASSWORD}" | docker login -u "${DOCKERHUB_USERNAME}" --password-stdin

# Ensure both latest and versioned tags exist before pushing
docker images | grep $DOCKER_IMAGE

# Push the latest and versioned tags
docker push $DOCKER_IMAGE:latest
docker push $DOCKER_IMAGE:$BUILD_DATE

