#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# gemini-cli
check "Options:" gemini --help

# Report result
reportResults
