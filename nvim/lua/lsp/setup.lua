local lspconfig = require("lspconfig") --这个模块相当于是neovim提供的lsp接口，mason这个提供具体的server来实现
local pid = vim.fn.getpid()

--https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
require("mason-lspconfig").setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({})
	end,
	-- Next, you can provide targeted overrides for specific servers.
	["lua_ls"] = function()
		lspconfig.lua_ls.setup({
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})
	end,
	["clangd"] = function()
		lspconfig.clangd.setup({
			cmd = {
				"clangd",
				"--header-insertion=never",
				"--query-driver=/opt/homebrew/opt/llvm/bin/clang",
				"--all-scopes-completion",
				"--completion-style=detailed",
			},
		})
	end,
	["omnisharp_mono"] = function()
		lspconfig.omnisharp_mono.setup({
			cmd = { "omnisharp-mono", "--languageserver", "--hostPID", tostring(pid) },
		})
		-- lspconfig.omnisharp_mono.setup({
		-- use_mono = true,
		-- })
	end,
})
