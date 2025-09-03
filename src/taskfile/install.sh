#!/usr/bin/env bash

apt-get update && apt-get install -y curl

sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin
