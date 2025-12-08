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
	"hrsh7th/nvim-cmp", -- 核心补全引擎
	dependencies = {
		"hrsh7th/cmp-path", -- 路径补全
		"hrsh7th/cmp-nvim-lsp", -- LSP 补全
		"hrsh7th/cmp-buffer", -- Buffer 补全
		"hrsh7th/cmp-cmdline", -- 命令行补全

		-- 【修改点1】：配置 LuaSnip 及其专用桥接插件
		"L3MON4D3/LuaSnip", -- 1. Snippet 引擎本体
		"saadparwaiz1/cmp_luasnip", -- 2. 关键：让 cmp 能看到 LuaSnip 的提示
		"rafamadriz/friendly-snippets", -- 3. 预置的常用代码段库
	},
	config = function()
		local cmp = require("cmp")
		-- 【修改点2】：必须引入 luasnip 模块，否则下方按键映射会找不到变量
		local luasnip = require("luasnip")

		-- 加载 friendly-snippets (vscode风格的代码段)
		require("luasnip.loaders.from_vscode").lazy_load()

		-- / 查找模式使用 buffer 源
		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- : 命令行模式中使用 path 和 cmdline 源
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})

		cmp.setup({
			-- 【修改点3】：指定 snippet 引擎为 LuaSnip
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body) -- 使用 luasnip 解析
				end,
			},
			-- 【修改点4】：sources 里要包含 luasnip，去掉 vsnip
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- 这里对应 cmp_luasnip
				{ name = "path" },
				{ name = "buffer" },
			}),
			mapping = cmp.mapping.preset.insert({
				-- 常规操作
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),

				["<CR>"] = cmp.mapping.confirm({
					select = true,
					behavior = cmp.ConfirmBehavior.Replace,
				}),

				-- 【修改点5】：修复后的 Tab 逻辑 (Super Tab)
				["<C-f>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						-- 1. 如果补全菜单可见，选下一个
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						-- 2. 如果在代码段中（如 func 括号内），跳到下一个位置
						luasnip.expand_or_jump()
					else
						-- 3. 否则也就是输入一个 Tab
						fallback()
					end
				end, { "i", "s" }),

				-- ["<S-Tab>"] = cmp.mapping(function(fallback)
				["<C-b>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
		})
	end,
}
return obj
