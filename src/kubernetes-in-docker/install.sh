#!/usr/bin/env bash

set -e

# The VERSION option is passed as an environment variable.
# The devcontainer-feature.json ensures it has a default.
KIND_VERSION="${VERSION}"

echo "Downloading kind version ${KIND_VERSION}..."

# Install kind
curl -Lo ./kind "https://kind.sigs.k8s.io/dl/v${KIND_VERSION}/kind-linux-amd64"
chmod +x ./kind
mv ./kind /usr/local/bin/kind
