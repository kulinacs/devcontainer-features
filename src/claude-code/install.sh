#!/usr/bin/env bash

set -e

VERSION="${VERSION:-stable}"

# Ensure we have curl and ca-certificates
if ! command -v curl >/dev/null 2>&1; then
    apt-get update && apt-get install -y ca-certificates curl
    rm -rf /var/lib/apt/lists/*
fi

# Detect platform
case "$(uname -s)" in
    Darwin) os="darwin" ;;
    Linux) os="linux" ;;
    *) echo "Unsupported operating system: $(uname -s)" >&2; exit 1 ;;
esac

case "$(uname -m)" in
    x86_64|amd64) arch="x64" ;;
    arm64|aarch64) arch="arm64" ;;
    *) echo "Unsupported architecture: $(uname -m)" >&2; exit 1 ;;
esac

# Check for musl on Linux and adjust platform accordingly
if [ "$os" = "linux" ]; then
    if [ -f /lib/libc.musl-x86_64.so.1 ] || [ -f /lib/libc.musl-aarch64.so.1 ] || ldd /bin/ls 2>&1 | grep -q musl; then
        platform="linux-${arch}-musl"
    else
        platform="linux-${arch}"
    fi
else
    platform="${os}-${arch}"
fi

GCS_BUCKET="https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases"

# Resolve version if it's "stable" or "latest"
if [[ "$VERSION" =~ ^(stable|latest)$ ]]; then
    resolved_version=$(curl -fsSL "$GCS_BUCKET/$VERSION")
else
    resolved_version="$VERSION"
fi

echo "Installing Claude Code version $resolved_version for $platform..."

# Simple JSON parser for extracting checksum when jq is not available
get_checksum_from_manifest() {
    local json="$1"
    local platform="$2"
    
    # Normalize JSON to single line and extract checksum
    json=$(echo "$json" | tr -d '\n\r\t' | sed 's/ \+/ /g')
    
    # Extract checksum for platform using bash regex
    if [[ $json =~ \"$platform\"[^}]*\"checksum\"[[:space:]]*:[[:space:]]*\"([a-f0-9]{64})\" ]]; then
        echo "${BASH_REMATCH[1]}"
        return 0
    fi
    
    return 1
}

# Download manifest and extract checksum
manifest_json=$(curl -fsSL "$GCS_BUCKET/$resolved_version/manifest.json")

if command -v jq >/dev/null 2>&1; then
    checksum=$(echo "$manifest_json" | jq -r ".platforms[\"$platform\"].checksum // empty")
else
    checksum=$(get_checksum_from_manifest "$manifest_json" "$platform")
fi

# Validate checksum format
if [ -z "$checksum" ] || [[ ! "$checksum" =~ ^[a-f0-9]{64}$ ]]; then
    echo "Platform $platform not found in manifest or invalid checksum" >&2
    exit 1
fi

# Download and verify
TARGET_PATH="/usr/local/bin/claude"
DOWNLOAD_URL="$GCS_BUCKET/$resolved_version/$platform/claude"

curl -fsSL -o "$TARGET_PATH" "$DOWNLOAD_URL"

# Verify checksum
if command -v sha256sum >/dev/null 2>&1; then
    actual=$(sha256sum "$TARGET_PATH" | cut -d' ' -f1)
elif command -v shasum >/dev/null 2>&1; then
    actual=$(shasum -a 256 "$TARGET_PATH" | cut -d' ' -f1)
else
    echo "No checksum tool found (sha256sum or shasum)" >&2
    exit 1
fi

if [ "$actual" != "$checksum" ]; then
    echo "Checksum verification failed! Expected $checksum, got $actual" >&2
    rm -f "$TARGET_PATH"
    exit 1
fi

chmod +x "$TARGET_PATH"

# Run claude install to set up launcher and shell integration
echo "Setting up Claude Code..."
# Use --yes if supported, but || true to avoid failure if it's not or if it requires more env vars
CI=true "$TARGET_PATH" install --yes || true

echo "✅ Claude Code installation complete!"
