#!/usr/bin/env bash

set -e

apt-get update && apt-get install -y ca-certificates curl

# Install ruff
# https://github.com/astral-sh/ruff
curl -LsSf https://astral.sh/ruff/install.sh | INSTALLER_NO_MODIFY_PATH=1 RUFF_INSTALL_DIR="/usr/local/bin" sh

rm -rf /var/lib/apt/lists/*
