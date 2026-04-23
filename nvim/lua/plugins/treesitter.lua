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

-- #############################################################################
-- 👇 【关键】手动注册 Vue 解析器（Neovim 内置没有，必须加这一段！）
-- #############################################################################
-- vim.treesitter.language.register("vue", "vue")

-- 确保 Vue 用 HTML + TS + CSS 完整高亮
-- vim.filetype.add({
-- 	extension = {
-- 		vue = "vue",
-- 	},
-- })

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
