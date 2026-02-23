#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# cloudflared
check "cloudflared --version" cloudflared --version

# Report result
reportResults
