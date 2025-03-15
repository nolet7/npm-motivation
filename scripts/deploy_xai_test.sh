#!/bin/bash
echo "Deploying to nolet7 xAI Test_Env (192.168.0.176)..."

ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa user@192.168.0.176 << 'EOF'
docker pull nolet7/npm-motivation:latest
docker stop npm-motivation || true
docker rm npm-motivation || true
docker run -d --name npm-motivation -p 3000:3000 nolet7/npm-motivation:latest
EOF

echo "Deployment to xAI Test_Env successful!"

