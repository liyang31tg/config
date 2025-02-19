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
	local function unmap(lhs)
		vim.keymap.del("n", lhs, { buffer = bufnr })
	end

	api.config.mappings.default_on_attach(bufnr)

	unmap("<c-e>")
	unmap("o")
	unmap("<c-t>")
	unmap("D")
	unmap("d")
	unmap("<c-x>")
	--抹掉bookmark功能
	unmap("M")
	unmap("m")
	unmap("bd")
	unmap("bt")
	unmap("bmv")
	map("n", "o", function()
		local node = api.tree.get_node_under_cursor()
		if node then
			if node.nodes ~= nil then
				--展开目录
				api.node.open.edit()
			else
				--预览文件
				api.node.open.preview()
			end
		else
			print("No node under cursor.")
		end
	end, "Print Node Path")

	map("n", "<c-h>", api.node.open.horizontal, "open horizontal")
	map("n", "x", api.node.navigate.parent_close, "关闭父级目录")
	map("n", "d", api.fs.trash, "删除到回收站")
	map("n", "<CR>", api.node.open.no_window_picker, "直接打开")
	map("n", "O", api.tree.expand_all, "Expand All")
	map("n", "?", api.tree.toggle_help, "Help")
	map("n", "C", api.tree.change_root_to_node, "CD")
	map("n", "u", api.tree.change_root_to_parent, "Up")
	map("n", "P", function()
		local node = api.tree.get_node_under_cursor()
		print(node.absolute_path)
	end, "Print Node Path")
	map("n", "Z", api.node.run.system, "Run System")
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
