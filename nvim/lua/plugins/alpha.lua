-- alpha-nvim 欢迎页：自定义 logo + 真实命令快捷入口 + 最近文件列表
--
-- 注意：本文件是 lazy 插件 spec，会在 lazy.setup 阶段被 require，
-- 所以顶层只能定义纯 lua 函数，不能 require alpha 模块（放到 config 回调里）。

-- 判断当前目录是否在 git 仓库内
local function in_git_repo()
	if vim.fs and vim.fs.root then
		return vim.fs.root(vim.fn.getcwd(), ".git") ~= nil
	end
	return vim.fn.finddir(".git", vim.fn.getcwd() .. ";") ~= ""
end

-- 安全打开 git 状态：非 git 目录时给出友好提示，而不是报错
_G.alpha_open_git_status = function()
	if not in_git_repo() then
		vim.notify("当前目录不在 git 仓库中", vim.log.levels.WARN, { title = "Git" })
		return
	end
	vim.cmd("Telescope git_status")
end

-- 安全打开 git 差异
_G.alpha_open_diffview = function()
	if not in_git_repo() then
		vim.notify("当前目录不在 git 仓库中", vim.log.levels.WARN, { title = "Git" })
		return
	end
	vim.cmd("DiffviewOpen")
end

return {
	"goolord/alpha-nvim",
	config = function()
		local dashboard = require("alpha.themes.dashboard")
		local theta = require("alpha.themes.theta")

		-- 顶部 Neovim logo
		dashboard.section.header.val = {
			"███╗   ██╗██╗   ██╗██╗███╗   ███╗",
			"████╗  ██║██║   ██║██║████╗ ████║",
			"██╔██╗ ██║██║   ██║██║██╔████╔██║",
			"██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
			"██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
			"╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
		}

		-- 常用入口：单字母触发，命令直接绑定（不依赖全局 keymap，保证可用）
		dashboard.section.buttons.val = {
			dashboard.button("f", " 󰈞  查找文件", "<cmd>Telescope find_files<cr>"),
			dashboard.button("s", " 󰊄  全局搜索", "<cmd>Telescope live_grep<cr>"),
			dashboard.button("e", " 󰙅  文件树", "<cmd>NvimTreeToggle<cr>"),
			dashboard.button("n", "   新建文件", "<cmd>enew<cr>"),
			dashboard.button("g", " 󰊢  Git 状态", "<cmd>lua _G.alpha_open_git_status()<cr>"),
			dashboard.button("d", "   Git 差异", "<cmd>lua _G.alpha_open_diffview()<cr>"),
			dashboard.button("t", " 󰊘  Todo 列表", "<cmd>TodoTelescope<cr>"),
			dashboard.button("c", "   配置文件", "<cmd>e $MYVIMRC<cr>"),
			dashboard.button("u", "   更新插件", "<cmd>Lazy sync<cr>"),
			dashboard.button("q", " 󰅚  退出", "<cmd>qa<cr>"),
		}
		-- 按钮之间不留空行，更紧凑
		dashboard.section.buttons.opts.spacing = 0

		-- 最近文件列表（MRU）：数字键直接打开
		local section_mru = {
			type = "group",
			val = {
				{ type = "text", val = " 最近文件", opts = { hl = "SpecialComment", position = "center" } },
				{ type = "padding", val = 1 },
				{
					type = "group",
					val = function()
						return { theta.mru(0, vim.fn.getcwd(), 5) }
					end,
					opts = { shrink_margin = false },
				},
			},
		}

		-- 底部：Neovim 版本 + 当前时间
		dashboard.section.footer.val = {
			"Neovim v"
				.. vim.version().major
				.. "."
				.. vim.version().minor
				.. "."
				.. vim.version().patch
				.. "   ·   "
				.. os.date("%Y-%m-%d %H:%M"),
		}
		dashboard.section.footer.opts.hl = "Comment"

		require("alpha").setup({
			layout = {
				{ type = "padding", val = 2 },
				dashboard.section.header,
				{ type = "padding", val = 1 },
				section_mru,
				{ type = "padding", val = 1 },
				dashboard.section.buttons,
				{ type = "padding", val = 1 },
				dashboard.section.footer,
			},
			opts = { margin = 5 },
		})
	end,
}
