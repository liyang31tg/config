# bun completions
[ -s "/Users/mac/.bun/_bun" ] && source "/Users/mac/.bun/_bun"
export HOMEBREW_NO_AUTO_UPDATE=1

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# frp
export FRP_INSTALL="$HOME/.frp"
export PATH="$FRP_INSTALL:$PATH"

#这句要保证在最后，否则会重复安装工具，总是检测到工具环境不存在
[[ -e ~/.config/zsh/zshrc ]] && source ~/.config/zsh/zshrc

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[[ -e $HOME/.local/bin/env ]] && . "$HOME/.local/bin/env"
