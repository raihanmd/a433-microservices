#!/bin/bash

# Define variables
IMAGE_NAME=karsajobs
TAG=latest
USERNAME=raihanmd

# Build docker image
echo "🔨 Building docker image $IMAGE_NAME:$TAG"
docker build -t $IMAGE_NAME:$TAG $(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) || { echo '❌ Build failed' ; exit 1; }

# List docker images
echo "📃 Listing images"
docker images

# Tag image
echo "🏷️ Tagging docker image $IMAGE_NAME:$TAG as ghcr.io/$USERNAME/$IMAGE_NAME:$TAG"
docker tag $IMAGE_NAME:$TAG ghcr.io/$USERNAME/$IMAGE_NAME:$TAG || { echo '❌ Tagging failed' ; exit 1; }

# Login
echo "🔑 Logging to ghcr.io"
echo "$GITHUB_TOKEN" | docker login ghcr.io -u "$USERNAME" --password-stdin || { echo '❌ Login failed' ; exit 1; }

# Push
echo "🚀 Pushing docker image to ghcr.io/$USERNAME/$IMAGE_NAME:$TAG"
docker push ghcr.io/$USERNAME/$IMAGE_NAME:$TAG || { echo '❌ Push failed' ; exit 1; }

echo "🎉 Done"