#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# prettier
check "prettier --version" prettier --version

# Report result
reportResults
