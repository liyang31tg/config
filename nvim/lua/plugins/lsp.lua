local function GenServers()
	local vue_plugin_path = vim.fn.expand("$MASON/packages")
		.. "/vue-language-server"
		.. "/node_modules/@vue/language-server"

	local servers = {
		lua_ls = {
			cmd = { "lua-language-server" },
			filetypes = { "lua" },
			settings = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
					diagnostics = { globals = { "vim" } },
				},
			},
		},

		gopls = {
			cmd = { "gopls" },
			settings = {
				gopls = {
					completeUnimported = true,
					usePlaceholders = true,
					analyses = { unusedparams = true },
				},
			},
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
		},

		vimls = {
			cmd = { "vim-language-server", "--stdio" },
			filetypes = { "vim" },
		},
		cssls = {
			cmd = { "vscode-css-language-server", "--stdio" },
			filetypes = { "css", "scss", "less" },
		},

		html = {
			cmd = { "vscode-html-language-server", "--stdio" },
			filetypes = { "html" },
			settings = {
				html = {
					embeddedLanguages = {
						javascript = true,
						css = true,
					},
					suggest = { html5 = true },
				},
				css = {
					lint = {
						emptyRules = "off",
						validProperties = "off",
						compatibleVendorPrefixes = "off",
						vendorPrefix = "off",
						unknownProperties = "off",
					},
				},
			},
		},

		bashls = {
			cmd = { "bash-language-server", "start" },
			filetypes = { "sh", "bash", "zsh" },
		},
		jsonls = {
			cmd = { "vscode-json-language-server", "--stdio" },
			filetypes = { "json", "jsonc" },
		},
		yamlls = {
			cmd = { "yaml-language-server", "--stdio" },
			filetypes = { "yaml", "yml" },
		},

		clangd = {
			cmd = {
				"clangd",
				"--header-insertion=never",
				"--query-driver=/opt/homebrew/opt/llvm/bin/clang",
			},
			filetypes = { "c", "cpp", "objc", "objcpp" },
		},

		ts_ls = {
			cmd = { "typescript-language-server", "--stdio" },
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

		vue_ls = {
			cmd = { "vue-language-server", "--stdio" },
			filetypes = { "vue" },
		},
	}

	return servers
end

local obj = {
	"williamboman/mason.nvim",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"ray-x/lsp_signature.nvim",
	},
	config = function()
		require("lsp_signature").setup()
		require("mason").setup()

		-- 🔥 必须加：让 Neovim 找到 Mason 安装的命令
		local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
		vim.env.PATH = mason_bin .. ":" .. vim.env.PATH

		-- 全局默认 capabilities，确保 nvim-cmp 能收到补全触发
		vim.lsp.config["*"] = {
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		}

		-- 延迟启动
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
