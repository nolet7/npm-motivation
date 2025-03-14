# Automated CI/CD Pipeline for npm-motivation

**Author:** Lateef Salam  
**Email:** nolet7@gmail.com  

## Overview
This project automates the **build, test, artifact storage, Docker image management, and deployment** of `npm-motivation`, an npm package stored in a **self-hosted Nexus repository** (`192.168.0.187`).

It includes **automatic versioning**, **multi-environment deployment (Test & Demo_Prod)**, and **GitHub Actions for CI/CD**.

## Features
- **Automated CI/CD Pipeline** using **GitHub Actions**
- **Versioning with Date & Time (`YYYY.MM.DD-HHMM`)**
- **Self-hosted Nexus Repository (`192.168.0.187`)** for npm artifacts
- **Docker Image Build & Push to DockerHub (`noletengine/npm-motivation`)**
- **Multi-Environment Deployment**:
  - **Test Environment**: `192.168.0.176`
  - **Demo_Prod Environment**: `192.168.0.119`
- **Deployment via SSH & Docker Compose**

## CI/CD Workflow Overview
### 1️⃣ Build & Test
- ✅ Checks out code
- ✅ Installs dependencies from **Nexus** (with fallback to `npmjs.org`)
- ✅ Runs unit tests

### 2️⃣ Publish to Nexus
-  Publishes versioned npm package to **Nexus (`192.168.0.187`)**

### 3️⃣ Build & Push Docker Image
-  Builds **Docker Image**
- Tags image with **date-based version**
- Pushes image to **DockerHub (`noletengine/npm-motivation`)**

### 4️⃣ Deploy to Multiple Environments
-  **Test Environment (`192.168.0.176`)**
-  **Demo_Prod Environment (`192.168.0.119`)**
-  Deploys **via SSH & Docker Compose**

## How to Manually Deploy via GitHub Actions
1. Go to **GitHub Repository → Actions**
2. Select **"Deploy npm-motivation"**
3. Click **"Run Workflow"**
4. Choose an environment:
   - `test` → Deploys to **Test** (`192.168.0.176`)
   - `demo_prod` → Deploys to **Demo_Prod** (`192.168.0.119`)
   - `all` → Deploys to **both environments**

## Running Locally
### Clone the Repository
```sh
git clone https://github.com/nolet7/motivational-cli.git
cd motivational-cli
```

### Install Dependencies
```sh
npm install
```

### Run Tests
```sh
npm test
```

### Build & Push Docker Image Locally
```sh
export DOCKERHUB_USERNAME="noletengine"
export DOCKERHUB_PASSWORD="<your-dockerhub-password-or-access-token>"
bash scripts/build_docker.sh
bash scripts/push_docker.sh
```

## Environment Variables & GitHub Secrets
### GitHub Secrets Required
| Secret Name  | Description |
|-------------|------------|
| `NPM_AUTH_TOKEN` | Nexus API Key for npm publishing |
| `DOCKER_USERNAME` | DockerHub Username |
| `DOCKER_PASSWORD` | DockerHub Password or Access Token |
| `TEST_SERVER_IP` | Test Environment IP (`192.168.0.176`) |
| `TEST_SERVER_USER` | Test SSH Username |
| `TEST_SSH_PRIVATE_KEY` | Test SSH Private Key |
| `DEMO_PROD_SERVER_IP` | Demo_Prod Environment IP (`192.168.0.119`) |
| `DEMO_PROD_SERVER_USER` | Demo_Prod SSH Username |
| `DEMO_PROD_SSH_PRIVATE_KEY` | Demo_Prod SSH Private Key |

## Deployment Architecture
```
+---------------------------+
|  GitHub Actions CI/CD     |
+---------------------------+
          │
          ▼
+---------------------------+
|  Build & Test (npm)       |
+---------------------------+
          │
          ▼
+---------------------------+
|  Publish to Nexus         |
|  (192.168.0.187)          |
+---------------------------+
          │
          ▼
+---------------------------+
|  Build Docker Image       |
+---------------------------+
          │
          ▼
+---------------------------+
|  Push to DockerHub        |
|  (noletengine/npm-motivation) |
+---------------------------+
          │
          ▼
+---------------------------+
|  Deploy to Test (192.168.0.176) |
+---------------------------+
          │
          ▼
+---------------------------+
|  Deploy to Demo_Prod (192.168.0.119) |
+---------------------------+
```

## Useful Commands
### Update Local Code & Push to GitHub
```sh
git add .
git commit -m "Updated CI/CD workflow"
git pull origin main --rebase
git push origin main
```

### Check Running Containers on Test/Demo_Prod
```sh
ssh user@192.168.0.176  # For Test
ssh user@192.168.0.119  # For Demo_Prod
docker ps
```

### Restart Service on Test/Demo_Prod
```sh
ssh user@192.168.0.176 'docker restart npm-motivation'
```

###  License
This project is **open-source** and follows standard licensing.

