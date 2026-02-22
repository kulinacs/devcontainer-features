#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# uv
check "uv --version" uv --version

# Report result
reportResults
