"后面需要用这个判断条件
source $HOME/.config/nvim/init_nomal.vim
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
lua require("plugin-config.mason")
lua require("plugin-config.mason-lspconfig")
lua require("plugin-config.comment")
lua require("plugin-config.nvim-treesitter-textobjects")
lua require("lsp.setup")
lua require("lsp.cmp") 
lua require("lsp.null-ls")
lua require("dap.nvim-dap")
lua require("dap.nvim-dap.go")




