#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# gcloud
check "Google Cloud SDK" gcloud --version

# Report result
reportResults
