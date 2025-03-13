#!/bin/bash
set -e  # Exit on error

echo "�� Uploading artifact to Nexus..."

NEXUS_URL="http://192.168.0.187:8081"
NEXUS_REPO="npm-motivation-artifacts"
ARTIFACT_PATH="./dist/npm-motivation.tar.gz"

if [[ ! -f "$ARTIFACT_PATH" ]]; then
    echo "❌ Build artifact not found! Run 'bash scripts/build.sh' first."
    exit 1
fi

# Upload artifact using Basic Auth and handle errors
HTTP_RESPONSE=$(curl -s -o response.txt -w "%{http_code}" -u admin:${NEXUS_API_KEY} --upload-file "$ARTIFACT_PATH" "$NEXUS_URL/repository/$NEXUS_REPO/npm-motivation.tar.gz")

if [[ "$HTTP_RESPONSE" -ne 201 ]]; then
    echo "❌ Failed to upload artifact! HTTP Response: $HTTP_RESPONSE"
    cat response.txt
    exit 1
fi

echo "✅ Artifact uploaded successfully to Nexus!"

