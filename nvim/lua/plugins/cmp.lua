--https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#vim-vsnip
local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local obj = {
	"hrsh7th/nvim-cmp", --补全引擎
	dependencies = {
		"hrsh7th/cmp-path", --路径补全源
		"hrsh7th/cmp-nvim-lsp", --lsp补全源
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		{
			"hrsh7th/cmp-vsnip", --将模版引擎转换来支持cmp协议
			dependencies = {
				"hrsh7th/vim-vsnip", --模版补全引擎
				dependencies = {
					"rafamadriz/friendly-snippets", --模版支持
				},
			},
		},
	},
	config = function()
		--cmp 是自动补全设置补全源的引擎设置
		local cmp = require("cmp")
		-- / 查找模式使用 buffer 源
		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- : 命令行模式中使用 path 和 cmdline 源.
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})
		cmp.setup({
			-- 指定 snippet 引擎
			snippet = {
				expand = function(args)
					-- For `vsnip` users.
					vim.fn["vsnip#anonymous"](args.body)

					-- For `luasnip` users.
					-- require('luasnip').lsp_expand(args.body)

					-- For `ultisnips` users.
					-- vim.fn["UltiSnips#Anon"](args.body)

					-- For `snippy` users.
					-- require'snippy'.expand_snippet(args.body)
				end,
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "vsnip" },
				{ name = "path" },
				{ name = "buffer" },
			}),
			mapping = require("keybindings").cmp(cmp, has_words_before, feedkey),
		})
	end,
}
return obj
