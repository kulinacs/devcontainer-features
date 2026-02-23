#!/usr/bin/env bash

set -e

apt-get update && apt-get install -y ca-certificates curl

# Install ty
# https://github.com/astral-sh/ty
curl -LsSf https://astral.sh/ty/install.sh | INSTALLER_NO_MODIFY_PATH=1 TY_INSTALL_DIR="/usr/local/bin" sh

rm -rf /var/lib/apt/lists/*
