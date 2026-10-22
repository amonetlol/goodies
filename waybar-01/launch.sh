#!/usr/bin/env bash
set -euo pipefail
export VORA_WAYBAR_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
exec waybar -c "$VORA_WAYBAR_DIR/config.jsonc" -s "$VORA_WAYBAR_DIR/style.css" "$@"
