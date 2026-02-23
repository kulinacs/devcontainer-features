#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# ty
check "ty --version" ty --version

# Report result
reportResults
