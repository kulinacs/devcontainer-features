#!/usr/bin/env bash

set -eux # Added -u for unset variables as error, -x for tracing

KN_VERSION="${VERSION}"
INCLUDE_QUICKSTART="${INCLUDEQUICKSTART}"

echo "Installing Knative CLI version ${KN_VERSION}..."

# Install kn
curl -fLo ./kn "https://github.com/knative/client/releases/download/knative-v${KN_VERSION}/kn-linux-amd64"
chmod +x ./kn
mv ./kn /usr/local/bin/kn

if [ "${INCLUDE_QUICKSTART}" = "true" ]; then
    echo "Installing Knative Quickstart plugin version ${KN_VERSION}..."
    curl -fLo ./kn-quickstart "https://github.com/knative-extensions/kn-plugin-quickstart/releases/download/knative-v${KN_VERSION}/kn-quickstart-linux-amd64"
    chmod +x ./kn-quickstart
    mv ./kn-quickstart /usr/local/bin/kn-quickstart
fi
