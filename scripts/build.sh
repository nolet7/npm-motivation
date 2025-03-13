#!/bin/bash
set -e  # Exit on error

echo "�� Installing dependencies..."
npm install

echo "�� Packaging the CLI tool..."
mkdir -p dist
tar -czvf dist/npm-motivation.tar.gz src/ package.json package-lock.json

echo "✅ Build complete! Artifact saved at dist/npm-motivation.tar.gz"

