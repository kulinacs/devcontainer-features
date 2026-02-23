#!/usr/bin/env bash

set -e

VERSION="${VERSION:-"latest"}"

if [ "$(id -u)" -ne 0 ]; then
    echo 'Script must be run as root' >&2
    exit 1
fi

# Determine architecture
architecture="$(uname -m)"
case ${architecture} in
    x86_64) arch=amd64 ;;
    aarch64 | arm64) arch=arm64 ;;
    *) echo "Architecture ${architecture} unsupported" >&2; exit 1 ;;
esac

# Install dependencies
apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg

# Download and install skaffold
echo "Downloading Skaffold v${VERSION} for ${arch}..."
curl -Lo /usr/local/bin/skaffold "https://storage.googleapis.com/skaffold/releases/v${VERSION}/skaffold-linux-${arch}"
chmod +x /usr/local/bin/skaffold

# Cleanup
rm -rf /var/lib/apt/lists/*

echo "Skaffold installation complete!"
