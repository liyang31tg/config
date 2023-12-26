vim.g.mapleader = " "
vim.g.maplocalleader = ","
local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

local function opts(desc)
	return { noremap = true, silent = true, desc = desc }
end

-- kitty 首先在mac环境中需要将option改成alt ，macos_option_as_alt yes
-- vim 可以识别alt+shelft+anykey ，不能识别ctrl+shelft+anykey
map("n", ",r", "<c-r>", opt) --kitty中c-r不知道什么情况下被限制了
-- 取消 s 默认功能
map("n", "s", "", opt)
map("c", "<c-j>", "<c-n>", {})
map("c", "<c-k>", "<c-p>", {})

map("n", "`", "~", opt)
map("n", "\\s", [[  :<c-u>%s\/\/g<left><left> ]], opt)
-- windows 分屏快捷键
map("n", "sl", ":vsp<CR>", opt)
map("n", "s|", ":vsp<CR>", opt)
map("n", "sj", ":sp<CR>", opt)
map("n", "s-", ":sp<CR>", opt)
-- 关闭其他
map("n", "so", "<c-w>o", opt)
-- Alt + hjkl  窗口之间跳转
--map("n", "<A-h>", "<C-w>h", opt)
map("n", "<c-h>", "<C-w>h", opt)
map("n", "<c-j>", "<C-w>j", opt)
map("n", "<c-k>", "<C-w>k", opt)
map("n", "<c-l>", "<C-w>l", opt)
-- move window
map("n", "<leader>wh", "<C-w>H", opt)
map("n", "<leader>wj", "<C-w>J", opt)
map("n", "<leader>wk", "<C-w>K", opt)
map("n", "<leader>wl", "<C-w>L", opt)

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", opts("Move down"))
map("n", "<A-k>", "<cmd>m .-2<cr>==", opts("Move up"))
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", opts("Move down"))
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", opts("Move up"))
map("v", "<A-j>", ":m '>+1<cr>gv=gv", opts("Move down"))
map("v", "<A-k>", ":m '<-2<cr>gv=gv", opts("Move up"))
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)

--tab 原生
map("n", "<leader>tn", ":tab split<cr>", opt)
map("n", "gt", ":+tabnext<cr>", opt) --默认值也是这个，写在这里只是方便记忆
map("n", "gT", ":-tabnext<cr>", opt) --默认值也是这个，写在这里只是方便记忆
map("n", ".t", ":+tabmove<cr>", opt)
map("n", ",t", ":-tabmove<cr>", opt)
map("n", "<leader>tq", "<cmd>tabclose<cr>", opt)

-- bufferline
-- 左右Tab切换
map("n", "[b", ":BufferLineCyclePrev<CR>", opt)
map("n", "]b", ":BufferLineCycleNext<CR>", opt)
-- 关闭
--"moll/vim-bbye"
map("n", "<leader>bq", ":Bdelete!<CR>", opt)
map("n", "<leader>bl", ":BufferLineCloseRight<CR>", opt)
map("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opt)
map("n", "<leader>bo", ":BufferLineCloseOthers<CR>", opt)
map("n", "<leader>bc", ":BufferLinePickClose<CR>", opt)
map("n", "<leader>bp", ":BufferLinePick<CR>", opt)
map("n", "<leader>b,", ":BufferLineMovePrev<CR>", opt)
map("n", "<leader>b.", ":BufferLineMoveNext<CR>", opt)
map("n", "<leader>bb", "<cmd>e #<cr>", opts("与上一个buffer切换"))

map(
	"n",
	"<leader>ur",
	"<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
	opts("Redraw / clear hlsearch / diff update")
)

map("n", "gw", "*N", opts("查询这个单词"))
map("x", "gw", "*N", opts("查询这个单词"))

-- copy from lazygit 不知道具体什么功能
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })
-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- 左右比例控制
map("n", "<Left>", ":vertical resize -2<CR>", opt)
map("n", "<Right>", ":vertical resize +2<CR>", opt)
map("n", "<C-Left>", ":vertical resize -20<CR>", opt)
map("n", "<C-Right>", ":vertical resize +20<CR>", opt)
-- 上下比例
map("n", "<C-Down>", ":resize +10<CR>", opt)
map("n", "<C-Up>", ":resize -10<CR>", opt)
map("n", "<Down>", ":resize +2<CR>", opt)
map("n", "<Up>", ":resize -2<CR>", opt)
-- 等比例
map("n", "s=", "<C-w>=", opt)

-- Terminal相关
-- map("n", "<c-t>", ":sp | terminal<CR>", opt)
-- map("n", "<leader>vt", ":vsp | terminal<CR>", opt)
-- map("t", "<Esc>", "<C-\\><C-n>", opt)
-- map("t", "<c-h>", [[ <C-\><C-N><C-w>h ]], opt)
-- map("t", "<c-j>", [[ <C-\><C-N><C-w>j ]], opt)
-- map("t", "<c-k>", [[ <C-\><C-N><C-w>k ]], opt)
-- map("t", "<c-l>", [[ <C-\><C-N><C-w>l ]], opt)
map("n", "<space>t", "<cmd>ToggleTerm<cr>", opt)
map("n", "<c-t>", "<cmd>ToggleTerm<cr>", opt)

-- 在visual 模式里粘贴不要复制
map("v", "p", '"_dP', opt)

-- 退出
map("n", "<leader>q", ":q<CR>", opt)
map("n", ",q", ":q!<CR>", opt)
map("n", "Q", ":qa!<CR>", opt)

-- insert 模式下，跳到行首行尾
map("i", "<C-i>", "<ESC>I", opt)
map("i", "<C-a>", "<ESC>A", opt)

--第三方插件的快捷键银蛇如下
local pluginKeys = {}
--nvim-tree
map("n", "<F3>", ":NvimTreeToggle<CR>", opt)
map("n", "<F2>", ":NvimTreeFocus<CR>", opt)
map("n", "<c-0>", ":NvimTreeFindFile<CR>", opt)
map("i", "<c-0>", ":NvimTreeFindFile<CR>", opt)
map("v", "<c-0>", ":NvimTreeFindFile<CR>", opt)
map("t", "<c-0>", ":NvimTreeFindFile<CR>", opt)
map("c", "<c-0>", ":NvimTreeFindFile<CR>", opt)

-- Telescope
-- 查找文件
map("n", "<C-p>", "<leader>ff", { silent = true })
-- 全局搜索
map("n", "<C-f>", "<leader>fg", { silent = true })
--buffer 搜索
map("n", "<Leader>/", "<leader>f/", { silent = true })

-- Telescope 列表中 插入模式快捷键
pluginKeys.telescopeList = {
	i = {
		-- 上下移动
		["<C-j>"] = "move_selection_next",
		["<C-k>"] = "move_selection_previous",
		["<Down>"] = "move_selection_next",
		["<Up>"] = "move_selection_previous",
		-- 历史记录
		["<C-n>"] = "cycle_history_next",
		["<C-p>"] = "cycle_history_prev",
		-- 关闭窗口
		["<C-c>"] = "close",
		-- 预览窗口上下滚动
		["<C-u>"] = "preview_scrolling_up",
		["<C-d>"] = "preview_scrolling_down",
	},
}

pluginKeys.whichkeys = {
	a = { "<cmd>Alpha<cr>", "Welcome" },
	r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
	e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
	C = { "<cmd>%bd|e#<CR>", "Close Other Buffers" },
	f = {
		name = "telescope",
		b = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Find buffers" },
		c = { "<cmd>lua require('telescope.builtin').colorscheme()<cr>", "Find colorscheme" },
		d = { "<cmd>lua require('telescope.builtin').diagnostics()<cr>", "Find diagnostics" }, --只针对一些打开的buffer
		f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Find files" },
		g = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Find grep str" },
		h = { "<cmd>lua require('telescope.builtin').git_branches()<cr>", "Find  branch logs" }, --history
		q = { "<cmd>lua require('telescope.builtin').autocommands()<cr>", "Find  branch logs" },
		s = {
			"<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>",
			"Find Document Symbols",
		},
		S = {
			"<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>",
			"Find Symobls",
		},
		["?"] = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Find  help" },
		["/"] = {
			"<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>",
			"Find text in current buffer",
		},
	},
	-- ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
	-- ["p"] = { "<cmd>Telescope projects<cr>", "Projects" },

	["p"] = { "<cmd>SessionManager load_session<cr>", "Projects" },

	["t"] = {
		"<cmd>UltestSummary<CR>",
		"Unit Test",
	},

	["o"] = {
		"<cmd>SymbolsOutline<CR>",
		"Outline",
	},
	["v"] = {
		"<cmd>lua require('telescope').extensions.neoclip.default(require('telescope.themes').get_ivy())<cr>",
		"Clipboard Manager",
	},

	d = {
		name = "Debug",
		R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
		E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
		X = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
		-- C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
		T = { "<cmd>lua require'dapui'.toggle('sidebar')<cr>", "Toggle Sidebar" },
		p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
		r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
		q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },

		-- b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
		-- c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
		-- d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
		-- e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
		-- g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
		-- h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
		-- S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
		-- i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
		-- o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
		-- t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
		-- u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
	},

	T = {
		name = "Trouble",
		t = { "<cmd>Trouble<cr>", "ToggleTrouble" },
		d = { "<cmd>Trouble document_diagnostics<cr>", "Document Diagnostics" },
		w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
		q = { "<cmd>Trouble quickfix<cr>", "Quick Fix" },
		u = { "<cmd>Trouble lsp_references<cr>", "Usage" },
		g = { "<cmd>Gitsigns setloclist<cr>", "Open changed hunk" },
	},

	-- g = {
	--   name = "Git",
	--   b = { "<cmd>VGit buffer_gutter_blame_preview<cr>", "File Blame" },
	--   d = { "<cmd>VGit buffer_diff_preview<cr>", "Diff File" },
	--   D = { "<cmd>VGit project_diff_preview<cr>", "Diff Project" },
	--   s = { "<cmd>VGit buffer_stage<cr>", "Stage File" },
	--   u = { "<cmd>VGit buffer_unstage<cr>", "Unstage File" },
	--   r = { "<cmd>VGit buffer_reset<cr>", "Reset File" },
	--   f = { "<cmd>VGit buffer_history_preview <cr>", "Reset File" },
	--
	--   B = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
	--   c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
	-- },

	g = {
		name = "Git",
		-- g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
		f = { "<cmd>DiffviewFileHistory<CR>", "File History" },
		p = { "<cmd>DiffviewOpen<CR>", "Diff Project" },
		n = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		N = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		S = { "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", "Stage Hunk" },
		u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
		U = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Diff",
		},
	},

	R = {
		name = "Replace",
		f = { "<cmd>lua require('spectre').open_file_search()<CR>", "Replace File" },
		p = { "<cmd>lua require('spectre').open()<CR>", "Replace Project" },
		s = { "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", "Search" },
		-- -- 全项目替换
		-- vim.keybinds.gmap("n", "<leader>rp", "", vim.keybinds.opts)
		-- -- 只替换当前文件
		-- vim.keybinds.gmap("n", "<leader>rf", , vim.keybinds.opts)
		-- -- 全项目中搜索当前单词
		-- vim.keybinds.gmap("n", "<leader>rw", , vim.keybinds.opts)
	},

	l = {
		name = "LSP",
		l = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		d = {
			"<cmd>Telescope lsp_document_diagnostics<cr>",
			"Document Diagnostics",
		},
		w = {
			"<cmd>Telescope lsp_workspace_diagnostics<cr>",
			"Workspace Diagnostics",
		},
		i = { "<cmd>LspInfo<cr>", "Info" },
		I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
		j = {
			"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
			"Next Diagnostic",
		},
		k = {
			"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
			"Prev Diagnostic",
		},
		q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
	},

	-- h = {
	--   a = { "<cmd>HSHighlight 1<cr>", "Hightlight 1" },
	--   b = { "<cmd>HSHighlight 2<cr>", "Hightlight 2" },
	--   c = { "<cmd>HSHighlight 3<cr>", "Hightlight 3" },
	--   d = { "<cmd>HSHighlight 4<cr>", "Hightlight 4" },
	--   e = { "<cmd>HSHighlight 5<cr>", "Hightlight 5" },
	--   f = { "<cmd>HSHighlight 6<cr>", "Hightlight 6" },
	--   u = { "<cmd>HSRmHighlight<cr>", "RemoveHighlight" },
	--   U = { "<cmd>HSRmHighlight rm_all<cr>", "RemoveAllHighlight" },
	-- },

	h = {
		name = "Help",
		-- b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		-- r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
	},

	-- t = {
	--   name = "Terminal",
	--   n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
	--   u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
	--   t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
	--   p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
	--   f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
	--   h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
	--   v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
	-- },
}

-- lsp
-- rename
-- -- calltree
-- map("n", "<leader>in", "<cmd>lua vim.lsp.buf.incoming_calls()<cr>", opt)

map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opt)
-- code action
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opt)
-- go xx
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
map("n", "gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opt)
map("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
map("n", "<space>D", "<cmd>lua vim.lsp.buf.declaraion()<CR>", opt)
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
-- map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
map("n", "gr", "<cmd>TroubleToggle lsp_references<cr>", opt)
-- diagnostic
map("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", opt)
map("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opt)
map("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opt)
map("n", "<leader><leader>", "<cmd>lua vim.lsp.buf.format({async = true})<CR>", opt)
-- 没用到
-- mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
-- mapbuf("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opt)
-- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
-- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
-- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)

-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp)
	return {
		-- 出现补全
		["<c-.>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		-- 取消
		["<c-,>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- 上一个
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		-- 下一个
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		-- 确认
		["<CR>"] = cmp.mapping.confirm({
			select = true,
			behavior = cmp.ConfirmBehavior.Replace,
		}),
		-- 如果窗口内容太多，可以滚动
		["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
	}
end

-- dap
pluginKeys.mapDAP = function()
	vim.keymap.set("n", "<F4>", function()
		require("dap").terminate()
	end)

	vim.keymap.set("n", "<F5>", function()
		require("dap").continue()
	end)
	vim.keymap.set("n", ",dr", function()
		require("dap").restart()
	end)
	vim.keymap.set("n", "<F9>", function()
		require("dap").step_into() --进入断点函数
	end)
	vim.keymap.set("n", "<F10>", function()
		require("dap").step_over() -- 单步
	end)
	vim.keymap.set("n", "<F12>", function()
		require("dap").step_out() --下一个断点
	end)
	vim.keymap.set("n", ",dd", function()
		require("dap").toggle_breakpoint()
	end)
	--设置条件断点
	vim.keymap.set("n", ",dc", function()
		-- require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
		require("dap").set_breakpoint(vim.fn.input("[Condition] > ")) -- 输入条件eg: a>18
	end)
	--清空所有断点
	vim.keymap.set("n", ",dx", function()
		require("dap").clear_breakpoints()
	end)
	vim.keymap.set({ "n", "v" }, ",dh", function()
		require("dap.ui.widgets").hover()
	end)
	vim.keymap.set({ "n", "v" }, ",dp", function()
		require("dap.ui.widgets").preview()
	end)
	vim.keymap.set("n", ",df", function()
		local widgets = require("dap.ui.widgets")
		widgets.centered_float(widgets.frames)
	end)
	vim.keymap.set("n", ",ds", function()
		local widgets = require("dap.ui.widgets")
		widgets.centered_float(widgets.scopes)
	end)

	--结束调试
	map(
		"n",
		",de",
		":lua require'dap'.close()<CR>"
			.. ":lua require'dap'.terminate()<CR>"
			.. ":lua require'dap.repl'.close()<CR>"
			.. ":lua require'dapui'.close()<CR>"
			.. "<C-w>o<CR>",
		opt
	)
	-- 开始调试
	-- map("n", "<F5>", ":lua require'dap'.continue()<CR>", opt)
	-- --  stepOver, stepOut, stepInto
	-- map("n", "<F9>", ":lua require'dap'.step_over()<CR>", opt)
	-- map("n", "<F10>", ":lua require'dap'.step_into()<CR>", opt)
	-- map("n", "<F12>", ":lua require'dap'.step_out()<CR>", opt)
	-- -- 设置断点
	-- map("n", "<leader>dd", ":lua require('dap').toggle_breakpoint()<CR>", opt)
	-- map("n", "<leader>dc", ":lua require('dap').clear_breakpoints()<CR>", opt)
	-- -- 弹窗
	-- map("n", "<leader>dh", ":lua require'dapui'.eval()<CR>", opt)
end
-- map  test
pluginKeys.mapTEST = function()
	map(
		"n",
		"<leader>tf",
		":lua require('neotest').run.run(vim.fn.getcwd())<CR>" .. ":lua require('neotest').output_panel.open()<cr>",
		opt
	)
end

pluginKeys.mapFanYi = function()
	map("n", "fy", "<cmd>TransToZH<CR>", opt)
end

pluginKeys.mapGo = function()
	vim.cmd("au FileType go nmap <buffer> <silent> <LocalLeader>r :GoRun -F %:p:h<cr>")
	vim.cmd("au FileType go nmap <buffer> <LocalLeader>b :GoBuild %:p:h<cr>")
	vim.cmd("au FileType go nmap <buffer> <LocalLeader>tb :GoAddTag bson<cr>")
	vim.cmd("au FileType go nmap <buffer> <LocalLeader>tj :GoAddTag json<cr>")
	vim.cmd("au FileType go nmap <buffer> <LocalLeader>tt :GoAddTag toml<cr>")
	vim.cmd("au FileType go nmap <buffer> <LocalLeader>ty :GoAddTag yaml<cr>")
	vim.cmd("au FileType go nmap <buffer> <LocalLeader>tx :GoAddTag xml<cr>")
	vim.cmd("au FileType go nmap <buffer> <LocalLeader>tc :GoClearTag <cr>")
	-- vim.cmd("au FileType go nmap <buffer> <LocalLeader>tf :GoTest -v -n 1 -f<cr>")
	vim.cmd("au FileType go nmap <buffer> <silent> K :lua vim.lsp.buf.hover()<CR>") --借用了上面的lsp，只是希望这个只在go这个文件生效
	vim.cmd("au FileType go nmap <buffer> <LocalLeader>gt :<c-u>GoAddTest<cr>")
	vim.cmd("au FileType go nmap <buffer> <LocalLeader>tf :GoTestFunc -v -n 1<cr>")
end

pluginKeys.mapTrouble = function()
	map("n", "<LocalLeader>xx", ":lua require('trouble').open()<cr>", opt)
	map("n", "<LocalLeader>xw", ":lua require('trouble').open('workspace_diagnostics')<cr>", opt)
	map("n", "<LocalLeader>xd", ":lua require('trouble').open('document_diagnostics')<cr>", opt)
	map("n", "<LocalLeader>xq", ":lua require('trouble').open('quickfix')<cr>", opt)
	map("n", "<LocalLeader>xl", ":lua require('trouble').open('loclist')<cr>", opt)
end

pluginKeys.mapJavascript = function()
	vim.cmd("au FileType javascript nmap <buffer> <silent> <LocalLeader>r :!node  %<cr>")
end

return pluginKeys
