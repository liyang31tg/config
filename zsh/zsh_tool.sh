#!/bin/bash

if ! type bun &>/dev/null; then
    echo "Installing bun... 请保证开启了代理"
    curl -fsSL https://bun.sh/install | bash
fi

if ! type fanyi &>/dev/null; then
    echo "Installing fanyi..."
    bun i fanyi -g
fi

# im-select 需要
brew tap daipeihust/tap

# 工具列表数组（可自由扩展）
declare -a tools=(
    "jq"
    "bat"    # 语法高亮cat替代
    "zoxide" # 智能目录跳转
    "fzf"    # 模糊搜索工具
    "zk"
    "lsd"
    "neofetch"
    "starship"
    "gitui"
    "im-select"
    "black"
    "isort"
    "buf"
    "prettierd"
    "shfmt"
    "stylua"
    "yamlfmt"
    '{"ripgrep": "rg"}'
    '{"universal-ctags": "ctags"}'
)

# 带进度提示的安装循环
for tool in "${tools[@]}"; do

    if [[ "$tool" == '{'* ]]; then
        # 解析JSON对象
        install_tool=$(echo "$tool" | jq -r 'keys[0]')
        check_cmd=$(echo "$tool" | jq -r '.[keys[0]]')
    else
        # 普通字符串
        install_tool="$tool"
        check_cmd="$tool"
    fi

    if ! command -v "${check_cmd}" >/dev/null 2>&1; then
        echo -e "\033[1;33m⇒\033[0m Installing \033[1;36m${install_tool}\033[0m..."
        if ! brew install "${install_tool}"; then
            echo -e "\033[1;31m✗ Failed to install ${install_tool}\033[0m" >&2
            exit 1
        fi
        echo -e "\033[1;32m✓ ${install_tool} installed\033[0m"
    fi
done

if [[ ! -e ${PLUGINS_PATH}/powerlevel10k/powerlevel10k.zsh-theme ]]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${PLUGINS_PATH}/powerlevel10k
fi

if [[ ! -e ${PLUGINS_PATH}/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${PLUGINS_PATH}/zsh-autosuggestions
fi

if [[ ! -e ${PLUGINS_PATH}/fzf-tab/fzf-tab.plugin.zsh ]]; then
    git clone https://github.com/Aloxaf/fzf-tab ${PLUGINS_PATH}/fzf-tab
fi

if [[ ! -e ${PLUGINS_PATH}/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]]; then
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ${PLUGINS_PATH}/fast-syntax-highlighting
fi
