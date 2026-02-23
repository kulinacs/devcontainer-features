#!/bin/bash

# This test file will be executed against an auto-generated devcontainer.json that
# includes the 'pre-commit' feature with no options.
#
# Eg:
# {
#    "image": "<vanilla-image-with-git-and-curl>",
#    "features": {
#      "pre-commit": {}
#    }
# }
#
# This test can be run with the following command (from the root of this repo):
#
#    devcontainer features test 
#                   --features pre-commit    
#                   --base-image mcr.microsoft.com/devcontainers/base:ubuntu 
#                   .

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
# The 'check' command comes from the dev-container-features-test-lib.
check "execute pre-commit --version" pre-commit --version

# Report result
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults
