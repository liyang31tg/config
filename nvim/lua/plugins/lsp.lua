local function GenServers()
	-- 路径（字符串，不要包装table！）
	local vue_plugin_path = vim.fn.expand("$MASON/packages")
		.. "/vue-language-server"
		.. "/node_modules/@vue/language-server"

	local servers = {
		lua_ls = {
			settings = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
					diagnostics = { globals = { "vim" } },
				},
			},
		},

		gopls = {
			settings = {
				gopls = {
					completeUnimported = true,
					usePlaceholders = true,
					analyses = { unusedparams = true },
				},
			},
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
		},

		vimls = {},
		cssls = {},
		html = {},
		bashls = {},
		jsonls = {},
		yamlls = {},
		dockerls = {},
		docker_compose_language_service = {},
		basedpyright = {},

		clangd = {
			cmd = {
				"clangd",
				"--header-insertion=never",
				"--query-driver=/opt/homebrew/opt/llvm/bin/clang",
			},
			filetypes = { "c", "cpp", "objc", "objcpp" },
		},

		-- ===========================================
		-- ✅ Vue3 官方唯一支持：ts_ls （不是 vtsls！）
		-- ===========================================
		ts_ls = {
			filetypes = {
				"javascript",
				"typescript",
				"vue",
				"javascriptreact",
				"typescriptreact",
			},
			init_options = {
				plugins = {
					{
						name = "@vue/typescript-plugin",
						location = vue_plugin_path,
						languages = { "vue" },
					},
				},
			},
		},

		-- ===========================================
		-- ✅ Vue 3 官方 LSP (Volar 2.x)
		-- ===========================================
		vue_ls = {
			filetypes = { "vue" },
		},
	}

	return servers
end

local obj = {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"folke/neodev.nvim",
		"ray-x/lsp_signature.nvim",
	},
	config = function()
		require("neodev").setup()
		require("lsp_signature").setup()
		require("mason").setup()

		-- 延迟启动，保证Mason就绪
		vim.schedule(function()
			local servers = GenServers()
			for s, c in pairs(servers) do
				vim.lsp.config(s, c)
				vim.lsp.enable(s)
			end
		end)
	end,
}

return obj
