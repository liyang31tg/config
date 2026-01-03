local function expand_collapse_open()
	local api = require("nvim-tree.api")
	local node = api.tree.get_node_under_cursor()
	if node == nil then
		return
	end
	if node.nodes ~= nil then
		if node.open then
			api.tree.collapse_all()
		else
			api.tree.expand_all()
		end
	else --- 预览文件
		api.node.open.preview()
	end
end

local function toggle_gitignore_custom_hidden_filter()
	local api = require("nvim-tree.api")
	api.tree.toggle_hidden_filter()
	api.tree.toggle_gitignore_filter()
	api.tree.toggle_custom_filter()
end

local function open()
	local api = require("nvim-tree.api")
	local node = api.tree.get_node_under_cursor()
	if node then
		if node.nodes ~= nil then
			--展开目录
			api.node.open.edit()
		else
			--预览文件
			api.node.open.preview()
		end
	end
end

local function print_node()
	local api = require("nvim-tree.api")
	local node = api.tree.get_node_under_cursor()
	if node then
		print(node.absolute_path)
	end
end
-- 列表操作快捷键
local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function map(mode, lhs, rhs, opts)
		-- 设置默认选项
		local default_opts = {
			remap = false,
			buffer = bufnr,
			silent = true,
			nowait = true,
		}

		-- 如果 opts 是字符串，将其转换为包含 desc 的表
		if type(opts) == "string" then
			opts = { desc = "nvim-tree: " .. opts }
		end

		-- 将传入的 opts 合并到默认选项中
		opts = vim.tbl_extend("force", default_opts, opts or {})

		-- 设置键映射
		vim.keymap.set(mode, lhs, rhs, opts)
	end

	-- api.config.mappings.default_on_attach(bufnr)
	-- 定义自定义函数以关闭所有展开的目录

	map("n", "C", api.tree.change_root_to_node, "修改跟目录")
	map("n", "<c-k>", api.node.show_info_popup, "节点信息")
	map("n", "<c-t>", api.node.open.tab, "打开到tab")
	map("n", "<c-v>", api.node.open.vertical, "open vertical")
	map("n", "<c-h>", api.node.open.horizontal, "open horizontal")
	map("n", "<BS>", api.node.navigate.parent_close, "关闭父级目录")
	map("n", "<CR>", api.node.open.no_window_picker, "Open")
	map("n", "<Tab>", api.node.open.preview, "从上一个窗口中打开")
	map("n", "<c-r>", api.node.run.cmd, "Run Command")
	map("n", "u", api.tree.change_root_to_parent, "Up 到上一级")
	map("n", "a", api.fs.create, "Create File Or Directory")
	--bookmark start
	map("n", "bd", api.marks.bulk.trash, "Trash Bookmarked 到回收站")
	map("n", "bmv", api.marks.bulk.move, "Move Bookmarked 到指定目录下")
	map("n", "m", api.marks.toggle, "Toggle Bookmark")
	--bookmark end
	--toggle filter start
	map("n", "B", api.tree.toggle_no_buffer_filter, "Toggle Filter: 是否只显示已经打开的buffer")
	map("n", "M", api.tree.toggle_no_bookmark_filter, "Toggle Filter: No Bookmark")
	-- map("n", "G", api.tree.toggle_git_clean_filter, "Toggle Filter: Git Clean 没测试成功")
	map("n", ".", toggle_gitignore_custom_hidden_filter, "Toggle Filter: Dotfiles")

	--toggle filter end
	map("n", "c", api.fs.copy.node, "Copy")
	map("n", "o", open, "edit or preview")
	-- map("n", "d", api.fs.remove, "Delete") --这个是删除了就不存在了,无法在回收站找到
	map("n", "d", api.fs.trash, "删除到回收站")
	map("n", "e", api.node.open.edit, "edit")
	map("n", "f", api.live_filter.start, "Live Filter: Start")
	map("n", "?", api.tree.toggle_help, "Help")
	map("n", "gy", api.fs.copy.basename, "Copy Basename")
	map("n", "y", api.fs.copy.filename, "Copy Name")
	map("n", "<c-y>", api.fs.copy.relative_path, "Copy Relative Path")
	map("n", "Y", api.fs.copy.absolute_path, "Copy Absolute Path")
	map("n", "J", api.node.navigate.sibling.last, "Last Sibling")
	map("n", "K", api.node.navigate.sibling.first, "First Sibling")
	map("n", "p", api.fs.paste, "Paste")
	map("n", "P", api.node.navigate.parent, "Parent Directory")
	map("n", "q", api.tree.close, "Close")
	map("n", "r", api.fs.rename, "Rename")
	map("n", "R", api.fs.rename_full, "Rename: Full Path")
	map("n", "U", api.tree.reload, "Refresh, 超级更新,就是Update,所以用U")
	map("n", "x", api.node.navigate.parent_close, "关闭父级目录")
	map("n", "<c-x>", api.fs.cut, "Cut")
	map("n", "O", expand_collapse_open, "toggle Expand/Collapse All")
	map("n", "<c-o>", api.node.run.system, "Run System")
	map("n", "<c-p>", print_node, "Print Node Path")
	map("n", "<2-LeftMouse>", api.node.open.edit, "Open")
end

local opt = {
	on_attach = my_on_attach, --可以自动以这个方法 NvimTreeGenerateOnAttach可以查看这个方法的快捷键银蛇
	-- 完全禁止内置netrw
	disable_netrw = true,
	-- 不显示 git 状态图标
	git = {
		enable = true,
	},
	--project plugin 需要这样设置
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	filters = {
		-- 隐藏 .文件
		dotfiles = true,
		-- 隐藏 node_modules 文件夹
		custom = { "node_modules", "*.meta" },
	},
	view = {
		-- 宽度
		width = 34,
		-- 也可以 'right'
		side = "left",
		-- 隐藏根目录
		-- hide_root_folder = false,
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
}
-- 自动关闭
vim.cmd([[
  autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
]])

vim.cmd([[
    :hi      NvimTreeExecFile    guifg=#ffa0a0
    :hi      NvimTreeSpecialFile guifg=#ff80ff gui=underline
    :hi      NvimTreeSymlink     guifg=Yellow  gui=italic
    :hi link NvimTreeImageFile   Title
]])

local obj = {
	"kyazdani42/nvim-tree.lua",
	config = function()
		require("nvim-tree").setup(opt)
	end,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
}

return obj
