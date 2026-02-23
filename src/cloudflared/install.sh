#!/usr/bin/env bash

set -e

apt-get update && apt-get install -y ca-certificates curl gnupg

# Add Cloudflare GPG key
mkdir -p --mode=0755 /usr/share/keyrings
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null

# Add Cloudflare repository
# Use "any" to support different Debian/Ubuntu versions generically
echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared any main' | tee /etc/apt/sources.list.d/cloudflared.list

# Install cloudflared
apt-get update
apt-get install -y cloudflared

# Clean up
rm -rf /var/lib/apt/lists/*
