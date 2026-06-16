if status is-interactive
# Commands to run in interactive sessions can go here
fastfetch
end


# ======================================
# 基础环境变量
# ======================================
set -Ux EDITOR nvim
set -Ux VISUAL nvim
set -Ux LANG en_US.UTF-8
set -Ux LC_ALL en_US.UTF-8

# PATH 追加（npm全局、cargo、bin）
fish_add_path ~/.npm-global/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.local/bin

# Go 配置（解决你之前网络404/ipv6失败）
set -Ux GOPROXY https://goproxy.cn,https://mirrors.aliyun.com/goproxy/,direct
set -Ux GO_IPV4_ONLY 1

# ======================================
# 缩写/别名 abbr（比alias好用，支持展开补全）
# ======================================
abbr v nvim
abbr ls eza --icons
abbr ll eza -l --icons
abbr la eza -la --icons
abbr y 'yazi'
abbr f 'f' # y函数自动cd目录
abbr wk "cd ~/go/workSpace"
abbr c "cd ~/.config"
abbr g "gitui"
abbr pacu sudo pacman -Syyu
abbr pacs pacman -Ss
abbr paru paru -Syu

# ======================================
# yazi 退出自动切换当前目录（fish版函数）
# ======================================
function f
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if test -f "$tmp"
        set cwd (cat "$tmp")
        if test -n "$cwd" -a "$cwd" != "$PWD"
            cd "$cwd"
        end
        rm -f "$tmp"
    end
end

# ======================================
# 提示符简易美化
# ======================================

function fish_prompt
    set -l ret $status
    if test $ret -eq 0
        set_color green
    else
        set_color red
    end
    echo -n (prompt_pwd) " "
    set_color yellow
    echo -n '$ '
    set_color normal
end

# 关闭开机欢迎语
set fish_greeting "天空😷巨响"
