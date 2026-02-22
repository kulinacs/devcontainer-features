#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# Feature-specific tests
check "gemini --version" gemini --version

# Report result
reportResults
