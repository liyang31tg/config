"加载lua
lua require('base')
lua require('keybindings')
lua require('plugins') --安装插件
lua require("lsp")
lua require("dap.nvim-dap")
lua require("plugin-config") --插件配置
lua require('autocmd')
lua require('colorscheme')

"覆盖前面的
source $HOME/.config/nvim/init_nomal.vim




