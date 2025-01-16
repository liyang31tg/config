function GenServers()
	local vue_typescript_plugin = require("mason-registry").get_package("vue-language-server"):get_install_path()
		.. "/node_modules/@vue/language-server"
		.. "/node_modules/@vue/typescript-plugin"
	-- .local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin
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
		-- tsserver = {},
		ts_ls = {
			single_file_support = false,
			-- https://lsp-zero.netlify.app/blog/configure-volar-v2.html  参考文章
			init_options = {
				plugins = {
					{
						name = "@vue/typescript-plugin",
						location = vue_typescript_plugin,
						languages = { "javascript", "typescript", "vue" },
					},
				},
			},
			filetypes = {
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
				"vue",
			},
		},
		volar = {}, --masoninstall vue-language-server@1.8.27, up this version not work in vue3 . 这个错误是因为2.0.0以后得版本不再内嵌ts
		yamlls = {},
		-- "vuels"
		-- denols = {}, --这个不能安装，会强制import以./ ../ 等开头的问
		dockerls = {},
		docker_compose_language_service = {},
		basedpyright = {},

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
	return servers
end

local obj = {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"folke/neodev.nvim",
		"ray-x/lsp_signature.nvim",
		-- "jose-elias-alvarez/null-ls.nvim", --有些lsp的供应商无法提供,formatter,code action,diagnostics的时候,由这个插件注入对应的功能,因为维护过大,作者已经放弃,暂时可用.
	},
	opts = {
		document_highlight = { enabled = false },
	},
	config = function()
		require("neodev").setup()
		-- init_null_ls()
		require("lsp_signature").setup()
		require("mason").setup()
		local servers = GenServers()
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
