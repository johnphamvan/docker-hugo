#!/bin/sh

# This file is triggered inside the _base/Dockerfile-base file.

set -e
set -u

# Variables
NODE_VERSION="14.15.1"

# Architecture
TARGETPLATFORM=${TARGETPLATFORM:-linux/amd64}

if [ "$TARGETPLATFORM" = "linux/amd64" ]; then
    NODE_ARCH="x64"
elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then
    NODE_ARCH="arm64"
elif [ "$TARGETPLATFORM" = "linux/arm/v7" ]; then
    NODE_ARCH="armv7l"
else
    echo "Unknown build architecture: $TARGETPLATFORM"
    exit 2
fi

# Download
wget https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-${NODE_ARCH}.tar.xz \
  -O /node.tar.xz

# Unpack
mkdir -p /files/usr/local
tar -xJf node.tar.xz -C /files/usr/local --strip-components=1 --no-same-owner
