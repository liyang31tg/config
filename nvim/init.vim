"加载lua
lua require('base')
lua require('keybindings')
lua require('plugins') --安装插件
lua require("plugin-config") --插件配置
lua require('autocmd')
lua require('colorscheme')
lua require("lsp.setup")
lua require("lsp.cmp")
lua require("lsp.null-ls")
lua require("dap.nvim-dap")
lua require("dap.nvim-dap.go")

"覆盖前面的
source $HOME/.config/nvim/init_nomal.vim




