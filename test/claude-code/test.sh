#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# claude-code
check "Claude Code" claude --version

# Report result
reportResults
