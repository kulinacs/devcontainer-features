#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# packer
check "Packer v" packer version

# Report result
reportResults
