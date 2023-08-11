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
map("n", "<c-t>", ":sp | terminal<CR>", opt)
map("n", "<leader>vt", ":vsp | terminal<CR>", opt)
map("t", "<Esc>", "<C-\\><C-n>", opt)
map("t", "<c-h>", [[ <C-\><C-N><C-w>h ]], opt)
map("t", "<c-j>", [[ <C-\><C-N><C-w>j ]], opt)
map("t", "<c-k>", [[ <C-\><C-N><C-w>k ]], opt)
map("t", "<c-l>", [[ <C-\><C-N><C-w>l ]], opt)

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
map("n", "<C-p>", ":Telescope find_files<CR>", opt)
-- 全局搜索
map("n", "<C-f>", ":Telescope live_grep<CR>", opt)
map("n", "<Leader>/", ":lua require('telescope.builtin').current_buffer_fuzzy_find() <cr>", opt)

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

-- lsp
-- rename
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opt)
-- code action
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opt)
-- go xx
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
map("n", "gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opt)
map("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
map("n", "<space>D", "<cmd>lua vim.lsp.buf.declaraion()<CR>", opt)
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
-- map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
map("n", "gr", "<cmd>TroubleToggle lsp_references<cr>", opt)
-- diagnostic
map("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", opt)
map("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opt)
map("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opt)
map("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({async = true})<CR>", opt)
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

-- nvim-dap
pluginKeys.mapDAP = function()
	vim.keymap.set("n", "<F5>", function()
		require("dap").continue()
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
	vim.keymap.set("n", "<Leader>dd", function()
		require("dap").toggle_breakpoint()
	end)
	vim.keymap.set("n", "<Leader>dl", function()
		require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
	end)
	vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
		require("dap.ui.widgets").hover()
	end)
	vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
		require("dap.ui.widgets").preview()
	end)
	vim.keymap.set("n", "<Leader>df", function()
		local widgets = require("dap.ui.widgets")
		widgets.centered_float(widgets.frames)
	end)
	vim.keymap.set("n", "<Leader>ds", function()
		local widgets = require("dap.ui.widgets")
		widgets.centered_float(widgets.scopes)
	end)

	--结束调试
	map(
		"n",
		"<leader>de",
		":lua require'dap'.close()<CR>"
			.. ":lua require'dap'.terminate()<CR>"
			.. ":lua require'dap.repl'.close()<CR>"
			.. ":lua require'dapui'.close()<CR>"
			.. ":lua require('dap').clear_breakpoints()<CR>"
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
	vim.cmd("au FileType go nmap <buffer> <LocalLeader>tf :GoTest -v -n 1 -f<cr>")
	vim.cmd("au FileType go nmap <buffer> <silent> K :lua vim.lsp.buf.hover()<CR>") --借用了上面的lsp，只是希望这个只在go这个文件生效
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
