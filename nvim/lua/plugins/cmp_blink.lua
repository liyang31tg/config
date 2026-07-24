-- return {
-- 	"saghen/blink.cmp",
-- 	dependencies = {
-- 		"saghen/blink.lib",
-- 		-- optional: provides snippets for the snippet source
-- 		"rafamadriz/friendly-snippets",
-- 	},
-- 	build = function()
-- 		-- build the fuzzy matcher, optionally add a timeout to `pwait(timeout_ms)`
-- 		-- you can use `gb` in `:Lazy` to rebuild the plugin as needed
-- 		require("blink.cmp").build():pwait()
-- 	end,
-- 	-- build = "cargo build --release",
--
-- 	---@module 'blink.cmp'
-- 	---@type blink.cmp.Config
-- 	opts = {
-- 		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
-- 		-- 'super-tab' for mappings similar to vscode (tab to accept)
-- 		-- 'enter' for enter to accept
-- 		-- 'none' for no mappings
-- 		--
-- 		-- All presets have the following mappings:
-- 		-- C-space: Open menu or open docs if already open
-- 		-- C-n/C-p or Up/Down: Select next/previous item
-- 		-- C-e: Hide menu
-- 		-- C-k: Toggle signature help (if signature.enabled = true)
-- 		--
-- 		-- See :h blink-cmp-config-keymap for defining your own keymap
-- 		keymap = {
-- 			-- preset = "default",
-- 			preset = "enter", -- Enter 确认，C-y 备用
-- 			["<Tab>"] = { "select_next", "fallback" },
-- 			["<S-Tab>"] = { "select_prev", "fallback" },
-- 		},
--
-- 		-- (Default) Only show the documentation popup when manually triggered
-- 		-- completion = { documentation = { auto_show = false } },
-- 		-- completion = {
-- 		-- 	documentation = {
-- 		-- 		auto_show = false,
-- 		-- 		auto_show_delay_ms = 300,
-- 		-- 	},
-- 		--
-- 		-- 	menu = {
-- 		-- 		-- 弹窗美化配置
-- 		-- 		border = "rounded", -- rounded/single/double/shadow/none
-- 		-- 		winhighlight = "Normal:Pmenu,FloatBorder:PmenuBorder,CursorLine:PmenuSel,Search:None",
-- 		-- 		scrollbar = true,
-- 		-- 		-- 最大显示条目数量
-- 		-- 		max_height = 12,
-- 		-- 	},
-- 		--
-- 		-- 	-- 下拉预览（光标悬停时在编辑器内预填文字）
-- 		-- 	ghost_text = {
-- 		-- 		enabled = true,
-- 		-- 	},
-- 		-- },
--
-- 		completion = {
-- 			-- 选中项目自动弹出文档（签名弹窗）
-- 			documentation = {
-- 				auto_show = true,
-- 				auto_show_delay_ms = 250, -- 悬停多久弹出文档
-- 				window = {
-- 					border = "rounded",
-- 					winhighlight = "Normal:Pmenu,FloatBorder:PmenuBorder",
-- 				},
-- 			},
--
-- 			menu = {
-- 				border = "rounded",
-- 				scrollbar = true,
-- 				max_height = 14,
-- 				winhighlight = "Normal:Pmenu,FloatBorder:PmenuBorder,CursorLine:PmenuSel,Search:None",
--
-- 				-- 布局：表格形式，右侧展示来源(lsp/snippet/path...)
-- 				draw = {
-- 					columns = {
-- 						{ "kind_icon" },
-- 						{ "label", "label_description", gap = 1 },
-- 						{ "source_name" }, -- ✅ 最右侧显示来源名称
-- 					},
-- 					-- 对齐方式，让来源靠右
-- 					padding = 1,
-- 					gap = 1,
-- 				},
-- 			},
--
-- 			-- 灰色预填充预览
-- 			ghost_text = { enabled = true },
-- 		},
--
-- 		-- (Default) list of enabled providers defined so that you can extend it
-- 		-- elsewhere in your config, without redefining it, due to `opts_extend`
-- 		sources = { default = { "lsp", "path", "snippets", "buffer" } },
--
-- 		-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
-- 		-- You may use a lua implementation instead by using `implementation = "lua"`
-- 		-- See the fuzzy documentation for more information
-- 		fuzzy = { implementation = "rust" },
-- 		signature = {
-- 			enabled = true,
-- 		},
-- 	},
-- }

return {
	"saghen/blink.cmp",
	dependencies = {
		"saghen/blink.lib",
		"rafamadriz/friendly-snippets",
	},
	opts = {
		appearance = {
			use_nvim_cmp_as_default = true, -- 兼容绝大多数主题高亮
			nerd_font_variant = "mono", -- 等宽NerdFont，图标对齐
		},

		-- ====== 按键映射｜改良enter方案（防止误接受补全）======
		keymap = {
			preset = "enter",
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
		},

		completion = {
			-- 关键：禁止自动预选第一条，防止菜单弹出直接回车误补全
			list = {
				selection = {
					preselect = true,
					auto_insert = false,
				},
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
			ghost_text = { enabled = true },

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

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		fuzzy = {
			implementation = "lua", -- 不需要rust编译
		},

		-- 你使用 lsp_signature.nvim，关闭blink内置签名窗口，避免双层弹窗冲突
		signature = { enabled = false },
	},
}
