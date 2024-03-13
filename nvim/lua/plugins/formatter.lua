local obj = {
	"stevearc/conform.nvim",
	opts = {
		--set ft? 获取文件的ft
		formatters_by_ft = {
			lua = { "stylua" },
			-- Conform will run multiple formatters sequentially
			go = { "goimports", "gofmt" },
			-- Use a sub-list to run only the first available formatter
			javascript = { { "my_prettierd", "prettier" } },
			typescript = { "my_prettierd" },
			vue = { "my_prettierd" },
			html = { "my_prettierd" },
			css = { "my_prettierd" },
			-- You can use a function here to determine the formatters dynamically
			python = function(bufnr)
				if require("conform").get_formatter_info("ruff_format", bufnr).available then
					return { "ruff_format" }
				else
					return { "isort", "black" }
				end
			end,
			json = { "my_prettierd" },
			yaml = { "my_prettierd" },
			xml = { "xmlformat" },
			csv = { "prettierd" },
			sh = { "shfmt" },
			zsh = { "shfmt" },
			proto = { "buf" },
			-- Use the "*" filetype to run formatters on all filetypes.
			["*"] = { "codespell" },
			-- Use the "_" filetype to run formatters on filetypes that don't
			-- have other formatters configured.
			["_"] = { "trim_whitespace" },
		},
		-- format_on_save = {
		-- I recommend these options. See :help conform.format for details.
		-- lsp_fallback = true,
		-- timeout_ms = 500,
		-- },
		formatters = {
			my_prettierd = {
				-- This can be a string or a function that returns a string.
				-- When defining a new formatter, this is the only field that is required
				command = "prettierd",
				-- A list of strings, or a function that returns a list of strings
				-- Return a single string instead of a list to run the command in a shell
				-- args = { "--stdin-from-filename", "$FILENAME" },
				args = { "$FILENAME" },
				-- If the formatter supports range formatting, create the range arguments here
				range_args = function(ctx)
					return { "--line-start", ctx.range.start[1], "--line-end", ctx.range["end"][1] }
				end,
				-- Send file contents to stdin, read new contents from stdout (default true)
				-- When false, will create a temp file (will appear in "$FILENAME" args). The temp
				-- file is assumed to be modified in-place by the format command.
				stdin = true,
				-- A function that calculates the directory to run the command in
				-- cwd = require("conform.util").root_file({ ".editorconfig", "package.json" }),
				-- When cwd is not found, don't run the formatter (default false)
				require_cwd = true,
				-- When returns false, the formatter will not be used
				condition = function(ctx)
					-- for key,value in pairs(ctx) do
					--     print(key,":",value)
					-- end
					-- return vim.fs.basename(ctx.filename) ~= "README.md"
					return true
				end,
				-- Exit codes that indicate success (default { 0 })
				-- exit_codes = { 0, 1 },  --这里不知道为啥修改,反正不修改作物的话,代码会变成一堆乱七糟八
				-- Environment variables. This can also be a function that returns a table.
				env = {
					PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/lua/utils/linter-config/.prettierrc.json"),
				},
				-- Set to false to disable merging the config with the base definition
				inherit = true,
				-- When inherit = true, add these additional arguments to the command.
				-- This can also be a function, like args
				prepend_args = { "--use-tabs" },
			},
		},
	},
}
return obj
