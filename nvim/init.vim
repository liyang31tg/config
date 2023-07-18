"后面需要用这个判断条件
let mapleader=" "
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction
if exists('g:vscode')
    " VSCode extension
    source  $HOME/.config/nvim/init_vscode.vim
else
    " ordinary neovim
    source  $HOME/.config/nvim/init_nomal.vim
endif

source $HOME/.config/nvim/base_comm.vim

"加载lua
lua require('base')
lua require('keybindings')
lua require('plugins')
lua require('colorscheme')
lua require("plugin-config.nvim-tree")
lua require("plugin-config.bufferline")
lua require("plugin-config.lualine")
lua require("plugin-config.telescope")
lua require("plugin-config.dashboard")
"lua require("plugin-config.project") 这个插件无法正常切换目录
lua require("plugin-config.nvim-treesitter")
lua require("lsp.setup")




