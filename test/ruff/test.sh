#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# ruff
check "ruff --version" ruff --version

# Report result
reportResults
