#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# gt
check "Graphite Version" gt --version

# Report result
reportResults
