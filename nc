#!/bin/bash
set -eufo pipefail
cd "$(dirname "$0")"
./busybox nc "$@"