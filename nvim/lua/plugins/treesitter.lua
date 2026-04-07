-- vim.opt.runtimepath:append("$HOME/.local/share/treesitter") --mark treesitter 存放目录,且下面必须指定目录位置,否则无法找到,将每次打开都重新安装一次
-- local opts = {
-- 	-- 安装 language parser
-- 	-- :TSInstallInfo 命令查看支持的语言
-- 	parser_install_dir = "$HOME/.local/share/treesitter",
-- 	auto_install = true, --进入buffer,检测到没有就安装
-- 	sync_install = false,
-- 	ensure_installed = { "json", "html", "css", "vim", "lua", "javascript", "typescript", "go" },
-- 	-- ensure_installed = "all", 启用代码高亮模块
-- 	highlight = {
-- 		enable = true,
-- 		disable = { "lua" }, -- 不要加强lua高亮,因为keybind那个文件会卡出翔
-- 		additional_vim_regex_highlighting = false, --关闭vim的正则高亮
-- 	},
-- 	indent = {
-- 		enable = true,
-- 	},
-- 	textobjects = {
-- 		select = {
-- 			enable = true,
--
-- 			-- Automatically jump forward to textobj, similar to targets.vim
-- 			lookahead = true,
--
-- 			keymaps = {
-- 				-- You can use the capture groups defined in textobjects.scm
-- 				["af"] = "@function.outer",
-- 				["if"] = "@function.inner",
-- 				["ac"] = "@class.outer",
-- 				-- You can optionally set descriptions to the mappings (used in the desc parameter of
-- 				-- nvim_buf_set_keymap) which plugins like which-key display
-- 				["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
-- 				-- You can also use captures from other query groups like `locals.scm`
-- 				["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
-- 			},
-- 			-- You can choose the select mode (default is charwise 'v')
-- 			--
-- 			-- Can also be a function which gets passed a table with the keys
-- 			-- * query_string: eg '@function.inner'
-- 			-- * method: eg 'v' or 'o'
-- 			-- and should return the mode ('v', 'V', or '<c-v>') or a table
-- 			-- mapping query_strings to modes.
-- 			selection_modes = {
-- 				["@parameter.outer"] = "v", -- charwise
-- 				["@function.outer"] = "V", -- linewise
-- 				["@class.outer"] = "<c-v>", -- blockwise
-- 			},
-- 			-- If you set this to `true` (default is `false`) then any textobject is
-- 			-- extended to include preceding or succeeding whitespace. Succeeding
-- 			-- whitespace has priority in order to act similarly to eg the built-in
-- 			-- `ap`.
-- 			--
-- 			-- Can also be a function which gets passed a table with the keys
-- 			-- * query_string: eg '@function.inner'
-- 			-- * selection_mode: eg 'v'
-- 			-- and should return true of false
-- 			include_surrounding_whitespace = false,
-- 		},
-- 	},
-- }

local api = vim.api
local ts = vim.treesitter

-- 不需要 Treesitter 的文件类型（黑名单）
local disabled_fts = {
	"notify",
	"lazy",
	"mason",
	"TelescopePrompt",
	"NvimTree",
	"noice",
	"qf",
	"help",
	"dashboard",
	"alpha",
	"gitignore",
	"log",
}

local function is_disabled()
	local ft = vim.bo.filetype
	return ft == "" or vim.tbl_contains(disabled_fts, ft)
end

-- 自动安装解析器（安全）
api.nvim_create_autocmd("BufEnter", {
	callback = function()
		if is_disabled() then
			return
		end

		local ok = pcall(ts.start)
		if not ok then
			vim.cmd("silent! TSInstallFromGrammar")
		end
	end,
})

-- 高亮 + 缩进 + 折叠（0.12 正确写法）
api.nvim_create_autocmd("FileType", {
	callback = function()
		if is_disabled() then
			return
		end

		-- 0.12 正确：启动就自动带高亮，不需要 highlight.enable
		pcall(ts.start)

		-- 缩进
		vim.bo.indentexpr = "v:lua.vim.treesitter.indent()"

		-- 折叠
		vim.wo.foldmethod = "expr"
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo.foldlevel = 99
	end,
})

local obj = {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	init = function()
		-- Disable entire built-in ftplugin mappings to avoid conflicts.
		-- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
		vim.g.no_plugin_maps = true

		-- Or, disable per filetype (add as you like)
		-- vim.g.no_python_maps = true
		-- vim.g.no_ruby_maps = true
		-- vim.g.no_rust_maps = true
		-- vim.g.no_go_maps = true
	end,
	config = function()
		-- put your config here
	end,
}

return obj
