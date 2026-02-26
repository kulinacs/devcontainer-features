#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# devcontainer-cli
check "devcontainer --help" devcontainer --help
check "devcontainer version" devcontainer --version

# Report result
reportResults
