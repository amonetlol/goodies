#!/usr/bin/env bash
set -euo pipefail
export VORA_WLOGOUT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
exec /usr/bin/wlogout -l "$VORA_WLOGOUT_DIR/layout" -C "$VORA_WLOGOUT_DIR/style.css" -b 5 -T 300 -B 300 "$@"
