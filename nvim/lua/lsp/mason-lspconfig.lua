local status, mason = pcall(require, "mason")
if not status then
	vim.notify("没有找到 mason")
	return
end

local status1, masonlspconfig = pcall(require, "mason-lspconfig")
if not status1 then
	vim.notify("没有找到 mason-lspconfig")
	return
end
--其他补全源
-- require("lsp.null-ls")

local lspconfig = require("lspconfig") --这个模块相当于是neovim提供的lsp接口，mason这个提供具体的server来实现
-- local pid = vim.fn.getpid()
--
-- mason start
mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})
-- mason end

--https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
local handler = {
	function(server_name)
		require("lspconfig")[server_name].setup({
			-- capabilities = capabilities,
		})
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
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
			root_dir = lspconfig.util.root_pattern(
				"CMakeLists.txt",
				".clangd",
				".clang-tidy",
				".clang-format",
				"compile_commands.json",
				"compile_flags.txt",
				"configure.ac",
				".git"
			),
			single_file_support = true,
		})
	end,
}

masonlspconfig.setup({
	-- 下面的lsp都可以在lsp.init这个模块这个配置文件里单独配置,一般默认的就可以使用
	ensure_installed = {
        "lua_ls",
		"gopls",
		"golangci_lint_ls",
		"vimls",
		"cssls",
		"html",
		"bashls",
		"jsonls",
		"tsserver",
		"yamlls",
		"volar",
		-- "vuels",
		-- "denols",这个不能安装，会强制import以./ ../ 等开头的问题
		"dockerls",
		"docker_compose_language_service",
		"clangd",

	}, --,"volar"
	handlers = handler,
})

