-- https://github.com/kyazdani42/nvim-tree.lua
-- local nvim_tree = require'nvim-tree'
local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
	vim.notify("没有找到 nvim-tree")
	return
end

-- 列表操作快捷键
local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	api.config.mappings.default_on_attach(bufnr)

	--vim.keymap.set('n', 'O', '', { buffer = bufnr })
	--vim.keymap.del('n', 'O', { buffer = bufnr })
	--vim.keymap.set('n', '<2-RightMouse>', '', { buffer = bufnr })
	--vim.keymap.del('n', '<2-RightMouse>', { buffer = bufnr })
	vim.keymap.set("n", "D", "", { buffer = bufnr })
	vim.keymap.del("n", "D", { buffer = bufnr })
	vim.keymap.del("n", "d", { buffer = bufnr })
	vim.keymap.del("n", "<c-x>", { buffer = bufnr })

	vim.keymap.set("n", "x", api.node.navigate.parent_close, opts("关闭父级目录"))
	vim.keymap.set("n", "d", api.fs.trash, opts("删除到回收站"))
	vim.keymap.set("n", "<CR>", api.node.open.no_window_picker, opts("直接打开"))
	vim.keymap.set("n", "O", api.tree.expand_all, opts("Expand All"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
	vim.keymap.set("n", "C", api.tree.change_root_to_node, opts("CD"))
	vim.keymap.set("n", "u", api.tree.change_root_to_parent, opts("Up"))
	vim.keymap.set("n", "<c-h>", api.node.open.horizontal, opts("open:水平"))
	vim.keymap.set("n", "P", function()
		local node = api.tree.get_node_under_cursor()
		print(node.absolute_path)
	end, opts("Print Node Path"))

	vim.keymap.set("n", "Z", api.node.run.system, opts("Run System"))
end

nvim_tree.setup({
	on_attach = my_on_attach, --可以自动以这个方法 NvimTreeGenerateOnAttach可以查看这个方法的快捷键银蛇
	-- 完全禁止内置netrw
	disable_netrw = true,
	-- 不显示 git 状态图标
	git = {
		enable = true,
	},
	--project plugin 需要这样设置
	update_cwd = true,
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	filters = {
		-- 隐藏 .文件
		dotfiles = true,
		-- 隐藏 node_modules 文件夹
		custom = { "node_modules" },
	},
	view = {
		-- 宽度
		width = 34,
		-- 也可以 'right'
		side = "left",
		-- 隐藏根目录
		hide_root_folder = false,
		-- 不显示行数
		number = false,
		relativenumber = false,
		-- 显示图标
		signcolumn = "yes",
	},
	renderer = {
		add_trailing = false,
		group_empty = false,
		full_name = false,
		root_folder_label = ":~:s?$?/..?",
		indent_width = 2,
		special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
		symlink_destination = true,
		highlight_git = false,
		highlight_diagnostics = false,
		highlight_opened_files = "none",
		highlight_modified = "none",
		highlight_clipboard = "name",
		indent_markers = {
			enable = false,
			inline_arrows = true,
			icons = {
				corner = "└",
				edge = "│",
				item = "│",
				bottom = "─",
				none = " ",
			},
		},
		icons = {
			web_devicons = {
				file = {
					enable = true,
					color = true,
				},
				folder = {
					enable = false,
					color = true,
				},
			},
			git_placement = "before",
			diagnostics_placement = "signcolumn",
			modified_placement = "after",
			padding = " ",
			symlink_arrow = " ➛ ",
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
				diagnostics = true,
				modified = true,
			},
			glyphs = {
				default = "",
				symlink = "",
				bookmark = "󰆤",
				modified = "●",
				folder = {
					arrow_closed = "➥",
					arrow_open = "↳",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = {
					unstaged = "✗",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "★",
					deleted = "",
					ignored = "◌",
				},
			},
		},
	},
	actions = {
		open_file = {
			-- 首次打开大小适配
			resize_window = true,
			-- 打开文件时关闭 tree
			quit_on_open = false,
		},
	},
	-- wsl install -g wsl-open
	-- https://github.com/4U6U57/wsl-open/
	system_open = {
		-- mac
		cmd = "open",
		-- windows
		-- cmd = "wsl-open",
	},
})
-- 自动关闭
vim.cmd([[
  autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
]])
