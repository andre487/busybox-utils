#!/usr/bin/env bash
set -eufo pipefail
cd "$(dirname "$0")/.."

if [[ $# == 0 ]]; then
    echo "Usage: $0 <some command> [<some flags>]}"
    exit 1
fi

bin_name="$1"
full_command=("$@")

cat <<- 'EOF' | sed "s/%command%/${full_command[*]}/g" > "$bin_name"
#!/bin/bash
set -eufo pipefail
cd "$(dirname "$0")"
./busybox %command% "$@"
EOF

chmod +x "$bin_name"
