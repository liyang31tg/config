-- m 映射的是alt控制键
-- c 映射的是ctrl控制键
local map = vim.keymap.set --该api不支持noremap属性,相反的你需要递归映射的就需要指定remap属性,类似一下面的remap=true
local unmap = vim.keymap.del
local remap = function(modes, lhs, rhs, opts)
	unmap(modes, lhs, opts)
	map(modes, lhs, rhs, opts)
end
-- local mapapi = vim.api.nvim_set_keymap
local opt = { remap = false, silent = true }

local function opts(desc)
	return { remap = false, silent = true, desc = desc }
end

-- map("n", "`", "~", opt) `是mark的前缀
--莫名多一个空格,用原生实现
map("n", "\\s", [[  :<c-u>%s//g<left><left> ]], { noremap = true })
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

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

-- move window 用winshelft替换
map("n", "M", "<cmd>WinShift<cr>", opt)
map("n", "mH", "<cmd>WinShift left<cr>", opt)
map("n", "mJ", "<cmd>WinShift down<cr>", opt)
map("n", "mK", "<cmd>WinShift up<cr>", opt)
map("n", "mL", "<cmd>WinShift right<cr>", opt)

-- Move Lines
map("v", "J", ":m '>+1<cr>gv=gv", opts("Move down"))
map("v", "K", ":m '<-2<cr>gv=gv", opts("Move up"))
map("v", "H", "<gv", opt)
map("v", "L", ">gv", opt)
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)

-- bufferline
-- 左右Tab切换
map("n", "[b", "<leader>b[", { silent = true, remap = true })
map("n", "]b", "<leader>b]", { silent = true, remap = true })

map(
	"n",
	"<leader>ur",
	"<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
	opts("Redraw / clear hlsearch / diff update")
)

--keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg 查询文档" })

map({ "n", "x" }, "gw", "*N", opts("查询这个单词"))

-- copy from lazygit 不知道具体什么功能
map({ "n", "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map({ "n", "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>xl", "<cmd>lopn<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

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
map("n", "<c-t>", "<cmd>ToggleTerm<cr>", opt)

-- 在visual 模式里粘贴不要复制
map("v", "p", '"_dP', opt)

-- 退出
map("n", "<leader>q", ":q<CR>", opt)
map("n", ",q", ":q!<CR>", opt)
map("n", "Q", ":qa!<CR>", opt)

-- insert 模式下，跳到行首行尾
map({ "n", "i" }, "<c-e>", "<ESC>A", opt) --now work
map({ "n", "i" }, "<c-a>", "<ESC>I", opt)

--第三方插件的快捷键银蛇如下
local pluginKeys = {}
--nvim-tree
map("n", "<F3>", ":NvimTreeToggle<CR>", opt)
map("n", "<F2>", ":NvimTreeFocus<CR>", opt)
map({ "n", "i", "v", "c", "t" }, "<c-0>", ":NvimTreeFindFile<CR>", opt)

-- Telescope
-- map("n", "<c-p>", ".tt", { silent = true, remap = true })
-- 查找文件
map("n", "<c-p>", "<leader>ff", { silent = true, remap = true })
-- 全局搜索
map("n", "<C-f>", "<leader>fg", { silent = true, remap = true })
--buffer 搜索
map("n", "<Leader>/", "<leader>f/", { silent = true, remap = true, desc = "文件搜索" })

pluginKeys.whichkeys = {
	{ "<leader>a", "<cmd>Alpha<cr>", desc = "Welcome" },
	{ "<leader>b", group = "Buffer" },
	{ "<leader>bd", "<cmd>Bdelete!<cr>", desc = "Close buffer" },
	{ "<leader>bD", "<cmd>bd<cr>", desc = "Close buffer And Window" },
	{ "<leader>bb", "<cmd>e #<cr>", desc = "swap with last buffer" },
	{ "<leader>bl", "<cmd>BufferLineCloseRight<cr>", desc = "Close Right buffers" },
	{ "<leader>bH", "<cmd>BufferLineCloseLeft<cr>", desc = "Close Left buffers" },
	{ "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close Others buffer" },
	{ "<leader>bc", "<cmd>BufferLinePickClose<cr>", desc = "Pick Buffer Close" },
	{ "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Pick Buffer" },
	{ "<leader>b,", "<cmd>BufferLineMovePrev<cr>", desc = "Buffer Move Prev" },
	{ "<leader>b.", "<cmd>BufferLineMoveNext<cr>", desc = "Buffer Move Next" },
	{ "<leader>b[", "<cmd>BufferLineCyclePrev<cr>", desc = "Focus Pre Buffer" },
	{ "<leader>b]", "<cmd>BufferLineCycleNext<cr>", desc = "Focus Next Buffer" },

	{ "<leader>d", group = "debug" },
	{ "<leader>dR", "<cmd>lua require'dap'.run_to_cursor()<cr>", desc = "Run to Cursor" },
	{ "<leader>dE", "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", desc = "Evaluate Input" },
	{ "<leader>dX", "<cmd>lua require'dap'.terminate()<cr>", desc = "Terminate" },
	-- { "<leader>dC", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", desc = "Conditional Breakpoint" },
	{ "<leader>dT", "<cmd>lua require'dapui'.toggle('sidebar')<cr>", desc = "Toggle Sidebar" },
	{ "<leader>dp", "<cmd>lua require'dap'.pause()<cr>", desc = "Pause" },
	{ "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "Toggle Repl" },
	{ "<leader>dq", "<cmd>lua require'dap'.close()<cr>", desc = "Quit" },

	{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },

	{ "<leader>f", group = "Telescope" },
	{ "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", desc = "Find Buffers" },
	{ "<leader>fc", "<cmd>lua require('telescope.builtin').colorscheme()<cr>", desc = "Find Colorscheme" },
	{ "<leader>fd", "<cmd>lua require('telescope.builtin').diagnostics({bufnr=0})<cr>", desc = "Find Diagnostics" },
	{ "<leader>fD", "<cmd>lua require('telescope.builtin').diagnostics()<cr>", desc = "Find Diagnostics" },
	{ "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", desc = "Find Files" },
	{ "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", desc = "Find Grep Str" },
	{ "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Find Projects" },
	{ "<leader>fq", "<cmd>lua require('telescope.builtin').autocommands()<cr>", desc = "Find  au" },
	{
		"<leader>fs",
		"<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>",
		desc = "Find Document Symbols",
	},
	{ "<leader>fw", "<cmd>lua require('telescope.builtin').grep_string()<cr>", desc = "Find Word" },
	{
		"<leader>fS",
		"<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>",
		desc = "Find Workspace Symbols",
	},
	{
		"<leader>f/",
		"<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>",
		desc = "Find in current buffer",
	},

	{ "<leader>g", group = "Git" },
	{ "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<cr>", desc = "GUI" },
	{ "<leader>ga", "<cmd>DiffviewOpen<CR>", desc = "Diff Project" },
	{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
	{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit" },
	{ "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Diff" },
	{ "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "Current File History" }, --当前文件的历史记录
	{ "<leader>gF", "<cmd>DiffviewFileHistory<cr>", desc = "Files History" }, --历史记录
	{ "<leader>gn", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", desc = "Next Hunk" },
	{ "<leader>gp", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", desc = "Prev Hunk" },
	{ "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame" },
	{ "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset Hunk" },
	{ "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer" },
	{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Open changed file" },
	{ "<leader>gx", "<cmd>DiffviewClose<cr>", desc = "DiffviewClose" },

	{ "<leader>o", "<cmd>Outline<CR>", desc = "Outline" },

	{ "<leader>p", group = "progress" },
	{ "<leader>gp", "<cmd>Telescope toggletasks spawn theme=dropdown<cr>", desc = "toggletasks select" },
	{ "<leader>gs", "<cmd>Telescope toggletasks select theme=dropdown<cr>", desc = "toggletasks select running task" },
	{ "<leader>ge", "<cmd>Telescope toggletasks edit theme=dropdown<cr>", desc = "toggletasks edit" },

	{ "<leader>rr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File" },

	{ "<leader>t", group = "Trouble" },
	{ "<leader>tt", "<cmd>Trouble<cr>", desc = "ToggleTrouble" },
	{ "<leader>tt", "<cmd>Trouble document_diagnostics<cr>", desc = "Document Diagnostics" },
	{ "<leader>tt", "<cmd>Trouble workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
	{ "<leader>tt", "<cmd>Trouble quickfix<cr>", desc = "Quick Fix" },
	{ "<leader>tt", "<cmd>Trouble lsp_references<cr>", desc = "Usage" },
	{ "<leader>tt", "<cmd>Gitsigns setloclist<cr>", desc = "Open changed hunk" },

	{ "<leader>T", group = "Terminal" },
	{ "<leader>Tn", "<cmd>lua _NODE_TOGGLE()<cr>", desc = "Node" },
	{ "<leader>Tu", "<cmd>lua _NCDU_TOGGLE()<cr>", desc = "NCDU" },
	{ "<leader>Tt", "<cmd>lua _HTOP_TOGGLE()<cr>", desc = "Htop" },
	{ "<leader>Tp", "<cmd>lua _PYTHON_TOGGLE()<cr>", desc = "Python" },
	{ "<leader>Tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float" },
	{ "<leader>Th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Horizontal" },
	{ "<leader>Tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical" },

	{ "<leader>R", group = "Replace" },
	{ "<leader>Rf", "<cmd>lua require('spectre').open_file_search()<CR>", desc = "Replace File" },
	{ "<leader>Rp", "<cmd>lua require('spectre').open()<CR>", desc = "Replace Project" },
	{ "<leader>Rs", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", desc = "Search" },

	{ "<leader>h", group = "Help" },
	{ "<leader>hc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
	{ "<leader>hh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
	{ "<leader>hM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
	{ "<leader>hR", "<cmd>Telescope registers<cr>", desc = "Registers" },
	{ "<leader>hk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
	{ "<leader>hC", "<cmd>Telescope commands<cr>", desc = "Commands" },

	{ "<leader>w", "<cmd>WinResizerStartMove<cr>", desc = "Move Win" },
	{ "<leader>z", "<cmd>ZenMode<cr>", desc = "ZenMode" },
}

-- lsp
-- rename
--
map("n", ",rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opt)
-- code action
map("n", ",ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opt)

map("n", ",li", "<cmd>LspInfo<cr>", opt) --show lsp info
-- go xx
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
map("n", "gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opt)
map("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
map("n", ",D", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
-- map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
map("n", ",gr", "<cmd>TroubleToggle lsp_references<cr>", opt)
map("n", "gr", "<cmd>Telescope lsp_references<cr>", opt)
-- diagnostic
map("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", opt)
map("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opt)
map("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opt)
-- map("n", "gf", "<cmd>lua vim.diagnostic.set_loclist()<CR>", opt) --Quickfix 与文件跳转冲突
-- map("n", "<leader><leader>", "<cmd>lua vim.lsp.buf.format({async = true})<CR>", opt)
map("n", "<leader><leader>", function()
	require("conform").format({ async = false })
end, opts("Format"))
-- 没用到
-- mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
-- mapbuf("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opt)
-- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
-- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
-- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
--

-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp, has_words_before, feedkey)
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
		["<c-l>"] = cmp.mapping(function(fallback)
			if vim.fn["vsnip#available"](1) == 1 then
				feedkey("<Plug>(vsnip-expand-or-jump)", "")
				-- elseif has_words_before() then
				--     cmp.complete()
			else
				fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
			end
		end, { "i", "s" }),

		["<c-h>"] = cmp.mapping(function()
			if vim.fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<Plug>(vsnip-jump-prev)", "")
			end
		end, { "i", "s" }),
	}
end

-- dap
pluginKeys.unmapTmpDAP = function()
	print("unmapBufferDAP")
	unmap("n", ",de", {})
	-- remap("n", ",de", "<cmd>echo 'dddd'<cr>", opt)

	unmap("n", "<leader>j", {})
	unmap("n", "<cr>", {})
	unmap("n", "<leader>k", {})
	unmap("n", "J", {})
	unmap({ "n", "v" }, ",dh", {})
	unmap("n", ",ds", {})
	unmap("n", ",da", {})
	unmap("n", ",dr", {})
end

pluginKeys.mapDAP = function()
	map("n", "<F5>", function()
		require("dap").continue()
	end, { desc = "启动断点" })
	map("n", ",dd", function()
		require("dap").toggle_breakpoint()
	end, { desc = "toggle breakpoint" })
	--设置条件断点
	map("n", ",dc", function()
		-- require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
		require("dap").set_breakpoint(vim.fn.input("[Condition] > ")) -- 输入条件eg: a>18
	end, { desc = "设置条件断点" })
	--清空所有断点
	map("n", ",dx", function()
		require("dap").clear_breakpoints()
	end, { desc = "clear all breakpoints" })
end

pluginKeys.mapTmpDAP = function()
	print("mapBufferDAP")
	-- map("n", "<F4>", function()
	--     require("dap").terminate()
	-- end)

	map("n", ",dr", function()
		require("dap").restart()
	end, { desc = "restart" })

	map("n", "<leader>k", function()
		require("dap").step_back() -- 单步回退,需要debugger支持才能用
	end, { desc = "step back" })

	map("n", "<cr>", function()
		require("dap").step_into() --进入断点函数
	end, { desc = "step into" })

	map("n", "<leader>j", function()
		require("dap").step_over() -- 单步,如果一个函数里,有断点,单步调试的时候也会进入该函数
	end, { desc = "step over" })

	map("n", "J", function()
		require("dap").step_out() --下一个断点
	end, { desc = "step out" })

	map({ "n", "v" }, ",dh", function()
		require("dap.ui.widgets").hover()
	end, { desc = "hover" })

	-- map({ "n", "v" }, ",dp", function()
	--     require("dap.ui.widgets").preview()
	-- end)

	map("n", ",ds", function()
		local widgets = require("dap.ui.widgets")
		widgets.centered_float(widgets.frames) --将栈信息显示在屏幕中间
	end, { desc = "show stack info" })

	map("n", ",da", function()
		local widgets = require("dap.ui.widgets")
		widgets.centered_float(widgets.scopes) --将变量信息显示在屏幕中间
	end, { desc = "show variable info" })

	--结束调试
	map(
		"n",
		",de",
		":lua require'dap'.terminate()<CR>",
		-- .. ":lua require'dap'.close()<CR>"
		-- .. ":lua require'dap.repl'.close()<CR>"
		-- .. ":lua require'dapui'.close()<CR>"
		-- .. "<C-w>o<CR>",
		{ desc = "end debug", silent = true }
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
pluginKeys.mapTEST = function() end

pluginKeys.mapFanYi = function()
	map("n", "fy", "<cmd>TransToZH<CR>", opt)
end

pluginKeys.mapGo = function()
	vim.cmd("au FileType go nmap <buffer> <silent> <LocalLeader>r :GoRun -F %:p:h<cr>")
	-- vim.cmd("au FileType go nmap <buffer> <LocalLeader>b :GoBuild -o cc %:p:h<cr>")
	vim.cmd("au FileType go nmap <buffer> <LocalLeader>b :!go build -o /tmp/ %:p:h<cr>")
	vim.cmd("au FileType go nmap <buffer> <LocalLeader>tb :GoAddTag bson<cr>")
	vim.cmd("au FileType go nmap <buffer> <LocalLeader>tj :GoAddTag json<cr>")
	-- vim.cmd("au FileType go nmap <buffer> <LocalLeader>tt :GoAddTag toml<cr>")
	vim.cmd("au FileType go nmap <buffer> <LocalLeader>ty :GoAddTag yaml<cr>")
	vim.cmd("au FileType go nmap <buffer> <LocalLeader>tx :GoAddTag xml<cr>")
	vim.cmd("au FileType go nmap <buffer> <LocalLeader>tc :GoClearTag <cr>")
	-- vim.cmd("au FileType go nmap <buffer> <LocalLeader>tf :GoTest -v -n 1 -f<cr>")
	vim.cmd("au FileType go nmap <buffer> <silent> K :lua vim.lsp.buf.hover()<CR>") --借用了上面的lsp，只是希望这个只在go这个文件生效
	-- vim.cmd("au FileType go nmap <buffer> <LocalLeader>gt :<c-u>GoAddTest<cr>")
	-- vim.cmd("au FileType go nmap <buffer> <LocalLeader>gt <cmd>lua require('neotest').summary.toggle()<cr>")
	vim.cmd("au FileType go nmap <buffer> <LocalLeader>ts <cmd>lua require('neotest').summary.toggle()<cr>")
	vim.cmd("au FileType go nmap <buffer> <LocalLeader>to <cmd>lua require('neotest').output_panel.toggle()<cr>")
	vim.cmd("au FileType go nmap <buffer> <LocalLeader>td <cmd>lua require('neotest').output_panel.clear()<cr>")
	vim.cmd("au FileType go nmap <buffer> <LocalLeader>tt <cmd>lua require('neotest').run.run()<cr>") --test single func
	vim.cmd("au FileType go nmap <buffer> <LocalLeader>tf <cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>") --test single file
	vim.cmd("au FileType go nmap <buffer> <LocalLeader>tw <cmd>lua require('neotest').run.run(vim.fn.getcwd())<cr>") --test workspace
	vim.cmd("au FileType go nmap <buffer> <LocalLeader>tg :GoTests<cr>")
end

pluginKeys.mapTrouble = function() end

pluginKeys.mapJavascript = function()
	vim.cmd("au FileType javascript nmap <buffer> <silent> <LocalLeader>r :!node  %<cr>")
	vim.cmd("au FileType typescript nmap <buffer> <silent> <LocalLeader>r :!ts-node  %<cr>")
end

vim.cmd("au FileType lua nmap <buffer> <silent> <LocalLeader>r :!lua  %<cr>")

pluginKeys.accelerated = function()
	map("n", "j", "<Plug>(accelerated_jk_gj)", opt)
	map("n", "k", "<Plug>(accelerated_jk_gk)", opt)
end

pluginKeys.mapTerminal = function()
	vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
	map({ "n", "o" }, "<F13>", [[<cmd>lua _BottomTerminal_TOGGLE() <cr>]], opt)
end

return pluginKeys
