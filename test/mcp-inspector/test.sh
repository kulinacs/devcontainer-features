#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# mcp-inspector
check "inspector-bin" mcp-inspector --help

# mcp-inspector-dev
check "inspector-bin" mcp-inspector-dev --help

# Report result
reportResults
