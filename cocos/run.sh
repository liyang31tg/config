#!/bin/zsh
# /usr/local/bin/nvim --server 127.0.0.1:6553 --remote $@
FILE="$1"
SOCKET="/tmp/nvimsocket"
NVR="/Library/Frameworks/Python.framework/Versions/3.10/bin/nvr"

[[ -S "$SOCKET" ]] || exit 1
"$NVR" --servername "$SOCKET" --remote-silent "$FILE" &
