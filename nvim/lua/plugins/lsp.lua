local servers = {
	lua_ls = {
		settings = {
			Lua = {
				workspace = { checkThirdParty = false },
				telemetry = { enable = false },
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	},
	gopls = {},
	vimls = {},
	cssls = {},
	html = {},
	bashls = {},
	jsonls = {},
	tsserver = {},
	yamlls = {},
	volar = {}, --masoninstall vue-language-server@1.8.27, up this version not work in vue3
	-- "vuels"
	-- "denols",这个不能安装，会强制import以./ ../ 等开头的问
	dockerls = {},
	docker_compose_language_service = {},

	clangd = {
		cmd = {
			"clangd",
			"--header-insertion=never",
			"--query-driver=/opt/homebrew/opt/llvm/bin/clang",
			"--all-scopes-completion",
			"--completion-style=detailed",
		},
		filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
		root_dir = require("lspconfig").util.root_pattern(
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
	},
}

local init_null_ls = function()
	local null_ls = require("null-ls")
	local formatting = null_ls.builtins.formatting
	local diagnostics = null_ls.builtins.diagnostics
	local code_actions = null_ls.builtins.code_actions
	local null_ls_opt = {
		debug = false,
		sources = {
			-- Formatting ---------------------
			--  brew install shfmt
			formatting.shfmt.with({
				filetypes = {
					"zsh",
					"sh",
				},
			}),
			-- StyLua
			formatting.stylua,

			formatting.clang_format, --{ "c", "cpp", "cs", "java", "cuda", "proto" }
			--go
			-- formatting.gofmt,
			formatting.goimports,
			formatting.goimports_reviser,
			formatting.gofumpt,
			-- formatting.golines,
			--YAML, JSON, XML, CSV
			formatting.yq,
			-- frontend
			-- yarn global add @fsouza/prettierd
			formatting.prettierd.with({
				env = {
					PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/lua/utils/linter-config/.prettierrc.json"),
				},
				filetypes = {
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"vue",
					"css",
					"scss",
					"less",
					"html",
					"json",
					"jsonc",
					"yaml",
					"markdown",
					"markdown.mdx",
					"graphql",
					"handlebars",
				},
			}),
			-- Diagnostics  ---------------------
			-- diagnostics.golangci_lint, --gopls感觉自己会报错,可以不用这个
			-- diagnostics.eslint.with({
			-- 	prefer_local = "node_modules/.bin",
			-- }),
			-- code actions ---------------------
			-- code_actions.eslint.with({
			-- 	prefer_local = "node_modules/.bin",
			-- }),
			-- code_actions.gomodifytags.with({ //不能用,这个功能可能会影响lsp提示不能及时有效
			-- 	command = "gomodifytags",
			-- 	args = { "-transform", "pascalcase" },
			-- }),
			-- code_actions.impl,

			-- formatting.fixjson,
			-- formatting.black.with({ extra_args = { "--fast" } }),
		},
		-- 保存自动格式化 ,如果这个命令异步了，就会造成很多2次保存，保存一次异步后界面变化了还要保存一次
		on_attach = function(_)
			vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({async=false})']])
		end,
	}
	null_ls.setup(null_ls_opt)
end

local obj = {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"folke/neodev.nvim",
		"ray-x/lsp_signature.nvim",
		"jose-elias-alvarez/null-ls.nvim", --有些lsp的供应商无法提供,formatter,code action,diagnostics的时候,由这个插件注入对应的功能,因为维护过大,作者已经放弃,暂时可用.
	},
	opts = {
		document_highlight = { enabled = false },
	},
	config = function()
		require("neodev").setup()
		-- init_null_ls()
		require("lsp_signature").setup()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = vim.tbl_keys(servers),
		})
		-- 这条可能可以删除
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		for server, config in pairs(servers) do
			require("lspconfig")[server].setup(vim.tbl_deep_extend("keep", { capabilities = capabilities }, config))
		end
	end,
}

return obj
