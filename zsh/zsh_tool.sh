#!/bin/bash

if ! type bun &>/dev/null; then
    echo "Installing bun... 请保证开启了代理"
    curl -fsSL https://bun.sh/install | bash
fi

if ! type fanyi &>/dev/null; then
    echo "Installing fanyi..."
    bun i fanyi -g
fi

if ! type gitui &> /dev/null;then
    echo "Installing gitui..."
    brew install gitui
fi

if ! type starship &> /dev/null;then
    echo "Installing starship..."
    brew install starship
fi

if ! type neofetch &> /dev/null;then
    echo "Installing neofetch..."
    brew install neofetch
fi

if ! type lsd &> /dev/null;then
    echo "Installing lsd.."
    brew install lsd
fi

if ! type zk &> /dev/null;then
    echo "Installing zk.."
    brew install zk
fi

if ! type bat &> /dev/null;then
    echo "Installing bat.."
    brew install bat
fi


if [[ ! -e ${PLUGINS_PATH}/powerlevel10k/powerlevel10k.zsh-theme ]];then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${PLUGINS_PATH}/powerlevel10k
fi

if [[ ! -e ${PLUGINS_PATH}/zsh-autosuggestions/zsh-autosuggestions.zsh ]];then
git clone https://github.com/zsh-users/zsh-autosuggestions ${PLUGINS_PATH}/zsh-autosuggestions
fi

if [[ ! -e ${PLUGINS_PATH}/fzf-tab/fzf-tab.plugin.zsh ]];then
git clone https://github.com/Aloxaf/fzf-tab ${PLUGINS_PATH}/fzf-tab
fi

if [[ ! -e ${PLUGINS_PATH}/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]];then
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ${PLUGINS_PATH}/fast-syntax-highlighting
fi

