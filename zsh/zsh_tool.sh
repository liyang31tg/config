#!/bin/bash

if ! type bun &>/dev/null; then
    echo "Installing bun... 请保证开启了代理"
    curl -fsSL https://bun.sh/install | bash
fi

if ! type fanyi &>/dev/null; then
    echo "Installing fanyi..."
    bun i fanyi -g
fi
