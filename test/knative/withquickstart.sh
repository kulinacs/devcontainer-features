#!/bin/bash

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
check "execute kn version" kn version

# Check if kn-quickstart is installed
if [ -f "/usr/local/bin/kn-quickstart" ]; then
    check "execute kn-quickstart version" kn-quickstart version
fi

# Report result
reportResults
