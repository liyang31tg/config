local obj = {
	"stevearc/conform.nvim",
	opts = {
		stop_after_first = false,
		debug = true,
		--set ft? 获取文件的ft
		formatters_by_ft = {
			lua = { "stylua" },
			-- Conform will run multiple formatters sequentially
			go = { "goimports", "gofmt" },
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			vue = { "prettierd" },
			html = { "prettierd" },
			css = { "prettierd" },
			-- You can use a function here to determine the formatters dynamically
			python = function(bufnr)
				if require("conform").get_formatter_info("ruff_format", bufnr).available then
					return { "ruff_format" }
				else
					return { "isort", "black" }
				end
			end,
			json = { "prettierd" },
			yaml = { "yamlfmt" }, -- go install github.com/google/yamlfmt/cmd/yamlfmt@latest
			xml = { "xmlformat" },
			csv = { "prettierd" },
			sh = { "shfmt" },
			zsh = { "shfmt" },
			proto = { "buf" },
			jsonc = { "prettierd" },
			-- Use the "*" filetype to run formatters on all filetypes.
			-- ["*"] = { "codespell" },
			-- Use the "_" filetype to run formatters on filetypes that don't
			-- have other formatters configured.
			["_"] = { "trim_whitespace" },
		},
		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 500,
			lsp_format = "fallback", -- "never", "always", "fallback",这个是优先使用lsp的格式化工具
		},
		formatters = {
			prettierd = {
				-- 继承内置 prettierd 的默认配置（关键：内置格式化器可以开 inherit）
				inherit = true,
				-- 方式1：通过环境变量指定全局配置文件（推荐）
				env = {
					PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/lua/utils/linter-config/.prettierrc.json"),
				},
				-- 方式2：（备选）通过参数直接指定配置文件（二选一即可）
				-- prepend_args = {
				--   "--config",
				--   vim.fn.expand("~/.config/nvim/lua/utils/linter-config/.prettierrc.json")
				-- },
			},
		},
	},
}
return obj
