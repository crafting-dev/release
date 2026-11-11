#!/bin/bash

CLI_BASE_URL="https://raw.githubusercontent.com/crafting-dev/release/refs/heads/master/artifacts/cs"
VERSION_URL="$CLI_BASE_URL/version.json"
: ${INSTALL_DIR:="/usr/local/bin"}

set +e  # Do not abort on a single command.
set +x  # Suppress debugging output.
set -o pipefail

function fatal() {
    echo "$@" >&2
    echo "Please use direct links from https://github.com/crafting-dev/release"
    exit 1
}

function ensure_curl() {
    curl --version 2>/dev/null | grep -E '^curl[[:space:]]+' >/dev/null 2>&1 || fatal "Command 'curl' not available."
}

function download_and_install() {
    local url="$1"
    [[ -d "$INSTALL_DIR" ]] || sudo mkdir -p "$INSTALL_DIR"
    curl -sSfL "$url" | sudo tar -C "$INSTALL_DIR" -zx
}

function value_in_json() {
  local prop="$1"
  grep -e '"'"$prop"'"\s*:\s*"[^"]*"' -o | sed -r 's/^"[^"]*"[[:space:]]*:[[:space:]]*"([^"]*)".*$/\1/g'
}

CLI_OS=
CLI_ARCH=

case "$OSTYPE" in
  linux*)
    CLI_OS=linux
    ;;
  darwin*)
    CLI_OS=darwin
    ;;
esac

case "$(uname -m 2>/dev/null || true)" in
    x86_64)
        CLI_ARCH=amd64
        ;;
    arm64*)
        CLI_ARCH=arm64
        ;;
    aarch64*)
        CLI_ARCH=arm64
        ;;
esac

[[ -n "$CLI_OS" && -n "$CLI_ARCH" ]] || fatal "Unknown OS or CPU architecture."

ensure_curl
VERSION_JSON="$(curl -sSfL "$VERSION_URL")"
FOLDER="$(echo "$VERSION_JSON" | value_in_json folder)"
[[ -n "$FOLDER" ]] || fatal "Unable to find latest CLI version."
URL="$(echo "$VERSION_JSON" | value_in_json url)"
[[ -z "$URL" ]] || CLI_BASE_URL="$URL"

echo "Ready to download Crafting CLI and install to $INSTALL_DIR."
echo "Please enter your sudo password when prompted."

download_and_install "$CLI_BASE_URL/$FOLDER/cs-${CLI_OS}-${CLI_ARCH}.tar.gz" || fatal "Download/Install failed."

echo
echo 'CLI "cs" has been installed to '$INSTALL_DIR' and is ready for use.'
echo
