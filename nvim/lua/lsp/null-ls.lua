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

		formatting.clang_format, --{ "c", "cpp", "cs", "java", "cuda", "proto" }
		--go
		-- formatting.gofmt,
		formatting.gofumpt,
		formatting.goimports,
		formatting.goimports_reviser,
		formatting.golines,
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
	-- 保存自动格式化 ,如果这个命令异步了，就会造成很多2次保存，保存一次异步后界面变化了还要保存一次
	on_attach = function(_)
		vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({async=false})']])
	end,
})
