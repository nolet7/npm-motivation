#!/bin/bash

# Ensure necessary environment variables are set
if [[ -z "$NEXUS_USERNAME" || -z "$NEXUS_PASSWORD" ]]; then
    echo "‚ùå Error: Nexus username and password are not set."
    echo "ÔøΩÔøΩ Please set NEXUS_USERNAME and NEXUS_PASSWORD environment variables."
    exit 1
fi

# Define Nexus repository URL
NEXUS_REPO_URL="http://192.168.0.187:8081/repository/npm-motivation-artifacts/"

# Ensure the package is built before publishing
ARTIFACT_PATH="./dist/npm-motivation.tar.gz"
if [[ ! -f "$ARTIFACT_PATH" ]]; then
    echo "‚ùå Build artifact not found!"
    echo "Ì≤° Run 'bash scripts/build.sh' first."
    exit 1
fi

# Setup .npmrc for authentication
echo "Ìª† Configuring npm authentication..."
echo "registry=$NEXUS_REPO_URL" > ~/.npmrc
echo "//192.168.0.187:8081/repository/npm-motivation-artifacts/:_auth=$(echo -n "$NEXUS_USERNAME:$NEXUS_PASSWORD" | base64)" >> ~/.npmrc
echo "email=nolet7@gmail.com" >> ~/.npmrc
echo "always-auth=true" >> ~/.npmrc

# Publish the package
echo "Ì∫Ä Uploading package to Nexus..."
npm publish --registry=$NEXUS_REPO_URL

# Check if publishing was successful
if [[ $? -eq 0 ]]; then
    echo "‚úÖ Successfully uploaded npm-motivation to Nexus!"
else
    echo "‚ùå Failed to upload the package."
    exit 1
fi

