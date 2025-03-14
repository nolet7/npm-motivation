#!/bin/bash
echo "Deploying to Demo_Prod_Env (192.168.0.119)..."

mkdir -p ~/.ssh
echo "${{ secrets.SSH_PRIVATE_KEY }}" > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa

ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa user@192.168.0.119 << 'EOF'
docker pull nolet7/npm-motivation:latest
docker stop npm-motivation || true
docker rm npm-motivation || true
docker run -d --name npm-motivation -p 3000:3000 nolet7/npm-motivation:latest
EOF

echo "Deployment to Demo_Prod_Env successful!"

