#!/usr/bin/env bash

set -e

apt-get update && apt-get install -y ca-certificates curl

# Install uv
# https://github.com/astral-sh/uv
curl -LsSf https://astral.sh/uv/install.sh | INSTALLER_NO_MODIFY_PATH=1 UV_INSTALL_DIR="/usr/local/bin" sh

rm -rf /var/lib/apt/lists/*
