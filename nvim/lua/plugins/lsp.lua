function GenServers()
	local vue_language_server_path = vim.fn.expand("$MASON/packages")
		.. "/vue-language-server"
		.. "/node_modules/@vue/language-server"
	-- local vue_language_server_path = '/path/to/@vue/language-server'
	local vue_plugin = {
		name = "@vue/typescript-plugin",
		location = vue_language_server_path,
		languages = { "vue" },
		configNamespace = "typescript",
	}

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
		gopls = {
			settings = {
				gopls = {
					completeUnimported = true,
					usePlaceholders = true,
					analyses = {
						unusedparams = true,
					},
				},
			},
			cmd = { "gopls" },
			-- 1. 修正文件类型
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
		},
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
						-- TODO:
						location = vue_language_server_path,
						languages = { "vue" },
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
		--好像下面2个不作用于vue
		vtsls = {
			init_options = {
				plugins = {
					vue_plugin,
				},
			},
			filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
		},
		vue_ls = {
			on_init = function(client)
				client.handlers["tsserver/request"] = function(_, result, context)
					local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
					if #clients == 0 then
						vim.notify(
							"Could not found `vtsls` lsp client, vue_lsp would not work with it.",
							vim.log.levels.ERROR
						)
						return
					end
					local ts_client = clients[1]

					local param = unpack(result)
					local id, command, payload = unpack(param)
					ts_client:exec_cmd({
						command = "typescript.tsserverRequest",
						arguments = {
							command,
							payload,
						},
					}, { bufnr = context.bufnr }, function(_, r)
						local response_data = { { id, r.body } }
						---@diagnostic disable-next-line: param-type-mismatch
						client:notify("tsserver/response", response_data)
					end)
				end
			end,
		},
		-- volar = {}, --masoninstall vue-language-server@1.8.27, up this version not work in vue3 . 这个错误是因为2.0.0以后得版本不再内嵌ts
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
		"folke/neodev.nvim",
		"ray-x/lsp_signature.nvim",
	},
	opts = {
		document_highlight = { enabled = false },
	},
	config = function()
		require("neodev").setup()
		require("lsp_signature").setup()
		require("mason").setup()
		-- 3. 引入 lspconfig 插件
		local lspconfig = require("lspconfig")
		local servers = GenServers()
		for server, config in pairs(servers) do
			lspconfig[server].setup(config)
			-- vim.lsp.config(server, config) 原生的需要手动注入一些配置,而使用上面这种插件注入,会有一些默认配置省略了很多配置
			-- vim.lsp.enable(server)
		end
	end,
}

return obj
