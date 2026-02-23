#!/usr/bin/env bash

set -e

# Import test library
. dev-container-features-test-lib

# Test that skaffold is on the path and works
check "skaffold version" skaffold version

# Report results
reportResults
