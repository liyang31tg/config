"加载lua
lua require('base')
lua require('keybindings')
lua require('plugins')
lua require('autocmd')
lua require('colorscheme')
lua require("plugin-config.nvim-tree")
lua require("plugin-config.bufferline")
lua require("plugin-config.lualine")
lua require("plugin-config.telescope")
lua require("plugin-config.project")
lua require("plugin-config.nvim-treesitter")
lua require("plugin-config.mason")
lua require("plugin-config.mason-lspconfig")
lua require("plugin-config.nvim-treesitter-textobjects")
lua require("plugin-config.mini")
lua require("plugin-config.dressing")
lua require("plugin-config.neotest")
lua require("plugin-config.go")
lua require("plugin-config.trouble")
lua require("plugin-config.js")
lua require("plugin-config.copilot")
lua require("lsp.setup")
lua require("lsp.cmp") 
lua require("lsp.null-ls")
lua require("dap.nvim-dap")
lua require("dap.nvim-dap.go")

"覆盖前面的
source $HOME/.config/nvim/init_nomal.vim




