return {
	"saghen/blink.cmp",
	dependencies = {
		{ "saghen/blink.lib", branch = "main" },
		"rafamadriz/friendly-snippets",
		"L3MON4D3/LuaSnip",
	},
	branch = "main",
	-- build = "cargo build --release", -- main分支必须手动写，无默认
	build = function()
		-- build the fuzzy matcher, optionally add a timeout to `pwait(timeout_ms)`
		-- you can use `gb` in `:Lazy` to rebuild the plugin as needed
		require("blink.cmp").build():pwait()
	end,
	config = function(_, opts)
		-- 加载 friendly-snippets 的 vscode 风格代码段，否则 luasnip 引擎里是空的
		require("luasnip.loaders.from_vscode").lazy_load()
		require("blink.cmp").setup(opts)
	end,
	opts = {

		enabled = function()
			-- nvim-tree rename/create/confirm 都是 buftype=nofile
			if vim.bo.buftype == "nofile" then --nvim-tree的添加与删除文件都没有补全
				return false
			end
			-- 保留 buffer 局部开关 vim.b.completion
			return vim.F.if_nil(vim.b.completion, true)
		end,
		appearance = {
			use_nvim_cmp_as_default = true, -- 兼容绝大多数主题高亮
			nerd_font_variant = "mono", -- 等宽NerdFont，图标对齐
		},

		-- ====== 按键映射｜改良enter方案（防止误接受补全）======
		keymap = {
			preset = "enter",
			["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<CR>"] = { "accept", "hide", "fallback" },
		},

		completion = {
			-- 关键：禁止自动预选第一条，防止菜单弹出直接回车误补全
			list = {
				selection = {
					preselect = true,
					auto_insert = false,
				},
			},

			trigger = {
				show_on_insert_on_trigger_character = true,
				-- show_on_blocked_trigger_characters = function(ctx)
				-- 	local char_before = ctx.cursor_before:sub(-1)
				-- 	-- 光标前是 ) 空格 \n \t，阻止自动弹出
				-- 	if char_before == ")" or char_before == " " or char_before == "\n" or char_before == "\t" then
				-- 		return true
				-- 	end
				-- 	return false
				-- end,
			},

			-- 自动括号（函数自动追加()，Go/gopls友好）
			accept = {
				auto_brackets = { enabled = true },
			},

			-- 选中条目自动浮动文档窗口（签名/注释）
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 220,
				treesitter_highlighting = true,
				window = {
					border = "rounded",
					winblend = 8, -- 透明度
					winhighlight = "Normal:Pmenu,FloatBorder:PmenuBorder",
				},
			},

			-- 行内预览灰色文字
			ghost_text = { enabled = false },

			menu = {
				border = "rounded",
				scrollbar = true,
				max_height = 14,
				winblend = 8, -- 弹窗整体透明度
				winhighlight = "Normal:Pmenu,FloatBorder:PmenuBorder,CursorLine:PmenuSel,Search:None",

				-- 表格布局定义
				draw = {
					treesitter = { "lsp" }, -- 补全项语法着色
					padding = 1,
					gap = 2,
					columns = {
						{ "kind_icon" },
						{ "label", "label_description", gap = 1 },
						{ "source_name" }, -- ✅ 最右侧展示来源 lsp/snippet/path/buffer
					},
					components = {
						source_name = {
							text = function(ctx)
								-- 美化来源显示 [LSP] [Snippet]
								local map = {
									lsp = "[LSP]",
									snippet = "[Snippet]",
									path = "[Path]",
									buffer = "[Buffer]",
								}
								return map[ctx.source_name] or ("[" .. ctx.source_name .. "]")
							end,
							highlight = "BlinkCmpSource",
						},
					},
				},
			},
		},

		snippets = { preset = "luasnip" }, --引擎要使用这个,官方默认的有问题,存在补全形参高亮不消失的问题

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			providers = {
				lsp = { score_offset = 15 },
				buffer = { score_offset = -5 },
			},
		},

		cmdline = {
			keymap = {
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
				["<CR>"] = { "accept", "hide", "fallback" },
			},
			completion = {
				list = {
					selection = {
						preselect = false,
						auto_insert = false,
					},
				},
				menu = {
					auto_show = function()
						return vim.fn.getcmdtype() ~= "/" and vim.fn.getcmdtype() ~= "?"
					end,
				},
				trigger = {
					show_on_blocked_trigger_characters = { "=" },
				},
			},
		},

		fuzzy = {
			-- implementation = "lua", -- 不需要rust编译
			implementation = "rust", -- 不需要rust编译
		},

		-- 你使用 lsp_signature.nvim，关闭blink内置签名窗口，避免双层弹窗冲突
		signature = { enabled = false },
	},
}
