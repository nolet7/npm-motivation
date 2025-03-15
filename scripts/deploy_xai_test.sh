#!/bin/bash
echo "íº€ Deploying to nolet7 xAI Test_Env (192.168.0.176)..."

# Connect to server using the correct SSH user
ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa nolet7@192.168.0.176 << 'EOF'
# Log in to DockerHub to ensure access
echo "${{ secrets.DOCKERHUB_PASSWORD }}" | docker login -u "${{ secrets.DOCKERHUB_USERNAME }}" --password-stdin

# Fetch the latest available tag from Docker Hub
IMAGE_TAG=\$(curl -s "https://registry.hub.docker.com/v2/repositories/noletengine/npm-motivation/tags" | jq -r '.results[0].name')

if [ -z "\$IMAGE_TAG" ]; then
  echo "âŒ Failed to retrieve image tag. Exiting."
  exit 1
fi

echo "â„¹ Using image: noletengine/npm-motivation:\$IMAGE_TAG"

# Pull the latest image dynamically
docker pull noletengine/npm-motivation:\$IMAGE_TAG

# Stop and remove the existing container if it exists
docker stop npm-motivation || true
docker rm npm-motivation || true

# Run the new container with the latest image
docker run -d --name npm-motivation -p 3000:3000 noletengine/npm-motivation:\$IMAGE_TAG
EOF

echo "âœ… Deployment to xAI Test_Env completed successfully!"

