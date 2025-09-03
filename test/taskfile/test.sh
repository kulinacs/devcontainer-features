#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# task
check "Usage: task" task --help

# Report result
reportResults
