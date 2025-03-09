#!/bin/bash

# Define image names
SERVER_IMAGE="bigcapital-server"
WEBAPP_IMAGE="bigcapital-webapp"

# Define paths relative to the project root
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SERVER_PATH="$ROOT_DIR/packages/server"
WEBAPP_PATH="$ROOT_DIR/packages/webapp"

# Ensure the script runs from the project root
cd "$ROOT_DIR" || { echo "Failed to change directory to project root"; exit 1; }

# Build server image
echo "Building Docker image for server..."
docker build -t "$SERVER_IMAGE" "$SERVER_PATH" || { echo "Failed to build server image"; exit 1; }

# Build webapp image
echo "Building Docker image for webapp..."
docker build -t "$WEBAPP_IMAGE" "$WEBAPP_PATH" || { echo "Failed to build webapp image"; exit 1; }

echo "✅ Docker images built successfully!"