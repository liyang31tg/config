local status, null_ls = pcall(require, "null-ls")
if not status then
	vim.notify("没有找到 null-ls")
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
	debug = false,
	sources = {
		-- Formatting ---------------------
		--  brew install shfmt
		formatting.shfmt,
		-- StyLua
		formatting.stylua,
		--go
		formatting.gofmt,
		formatting.goimports,
		formatting.goimports_reviser,
		formatting.golines,
		--YAML, JSON, XML, CSV
		formatting.yq,
		-- frontend
		formatting.prettier.with({ -- 只比默认配置少了 markdown
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
				"yaml",
				"graphql",
			},
			prefer_local = "node_modules/.bin", --npm install -D prettier eslint 表示本地依赖
		}),
		-- Diagnostics  ---------------------
		diagnostics.eslint.with({
			prefer_local = "node_modules/.bin",
		}),
		-- code actions ---------------------
		code_actions.eslint.with({
			prefer_local = "node_modules/.bin",
		}),
		code_actions.gomodifytags,
		code_actions.impl,

		-- formatting.fixjson,
		-- formatting.black.with({ extra_args = { "--fast" } }),
	},
	-- 保存自动格式化
	on_attach = function(_)
		vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({async=true})']])
	end,
})
