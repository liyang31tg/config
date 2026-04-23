-- m 映射的是alt控制键
-- c 映射的是ctrl控制键
-- 定义 map 函数，带有默认选项
local function map(mode, lhs, rhs, opts)
	-- 设置默认选项
	local default_opts = { remap = false, silent = true, unique = false }

	-- 如果 opts 是字符串，将其转换为包含 desc 的表
	if type(opts) == "string" then
		opts = { desc = opts }
	end

	-- 将传入的 opts 合并到默认选项中
	opts = vim.tbl_extend("force", default_opts, opts or {})

	-- 设置键映射
	vim.keymap.set(mode, lhs, rhs, opts)
end

local function unmap(mode, lhs, opts)
	opts = opts or {}
	opts.noremap = true
	vim.keymap.del(mode, lhs, opts)
end

-- comment or uncomment 已经使用<leader>cc替换
unmap("n", "gc")
unmap("n", "gcc")

--默认行为有个:tag的意思,容易引起误会
map("n", "<c-t>", "<Nop>")
--莫名多一个空格,用原生实现
map("n", "\\s", ":<c-u>%s//g<left><left>", { silent = false, remap = false })
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", "Escape and Clear hlsearch")

-- 修改搜索的时候{n/N}的行为，默认行为，这2个命令的方式是根据/?的搜索来决定的
map({ "n", "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "下一个搜索" })
map({ "n", "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "上一个搜索" })

-- windows 分屏快捷键
map("n", "sh", ":vsp<cr><c-w>h", "左边分屏")
map("n", "sj", ":sp<cr>", "下边分屏")
map("n", "sk", ":sp<cr><c-w>k", "上边分屏")
map("n", "sl", ":vsp<cr>", "右边分屏")
map("n", "so", "<c-w>o", "关闭其他")
-- win 聚焦
map("n", "<c-h>", "<C-w>h")
map("n", "<c-j>", "<C-w>j")
map("n", "<c-k>", "<C-w>k")
map("n", "<c-l>", "<C-w>l")
-- 左右比例控制
map("n", "<Left>", ":vertical resize -2<CR>")
map("n", "<Right>", ":vertical resize +2<CR>")
map("n", "<C-Left>", ":vertical resize -20<CR>")
map("n", "<C-Right>", ":vertical resize +20<CR>")
-- 上下比例
map("n", "<C-Down>", ":resize +20<CR>")
map("n", "<C-Up>", ":resize -20<CR>")
map("n", "<Down>", ":resize +2<CR>")
map("n", "<Up>", ":resize -2<CR>")
-- 等比例
map("n", "s=", "<C-w>=")
-- 交换窗口
map("n", "<leader>ww", "<cmd>WinShift<cr>", "进入分屏模式")
map("n", "<leader>wh", "<cmd>WinShift left<cr>", "Move Win Left")
map("n", "<leader>wj", "<cmd>WinShift down<cr>", "Move Win down")
map("n", "<leader>wk", "<cmd>WinShift up<cr>", "Move Win up")
map("n", "<leader>wl", "<cmd>WinShift right<cr>", "Move Win right")

-- Move Lines
map("v", "J", ":m '>+1<cr>gv=gv", "Move down")
map("v", "K", ":m '<-2<cr>gv=gv", "Move up")
map("v", "H", "<gv", "Move left")
map("v", "L", ">gv", "Move right")

-- bufferline
-- 左右Tab切换
map("n", "[b", "<leader>b[", { remap = true, desc = "Previous Buffer" })
map("n", "]b", "<leader>b]", { remap = true, desc = "Next Buffer" })

-- 修复diff对齐点,很少用
map("n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", "Redraw / clear hlsearch / diff update")

map("c", "<c-a>", "<Home>", { silent = false, desc = "Home" })

--keywordprg
map("n", "<leader>K", "<cmd>normal! K<cr>", { desc = "Keywordprg 查询文档" })

map({ "n", "x" }, "*", "*N", "高亮这个单词")

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- diagnostic
local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- highlights under cursor not work
-- map("n", "<local eader>ui", vim.show_pos, { desc = "Inspect Pos" })
-- map("n", "<leader>uI", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })

-- 在visual 模式里粘贴不要复制
map("x", "p", '"_dP')
-- map("n", "d", '"_d') --阐述的时候不要复制
map("n", "<D-S-f>", function()
	require("grug-far").open({})
end, "全局替换（仅当前工作目录）")

-- 退出
map("n", "<leader>q", ":q<CR>", "退出")
map("n", "<leader>Q", ":q!<CR>", "强制退出")
map("n", "Q", ":qa!<CR>", "关闭所有")

-- insert 模式下，跳到行首行尾
-- 还原终端下的某些行为
map({ "n" }, "<c-a>", "<ESC>I")
map({ "i", "c" }, "<c-f>", "<right>")
map({ "i", "c" }, "<c-b>", "<left>")
map({ "i", "c" }, "<c-a>", "<home>")
map({ "i", "c" }, "<c-e>", "<end>")

--第三方插件的快捷键银蛇如下
local pluginKeys = {}
--nvim-tree
map({ "n", "i", "v", "c", "t" }, "<c-0>", ":NvimTreeFindFile<CR>")
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", "Explorer")

map("n", "]t", function()
	require("todo-comments").jump_next()
end, "Next Todo Comment in current buffer")

map("n", "[t", function()
	require("todo-comments").jump_prev()
end, "Previous Todo Comment in current buffer")

-- Telescope
map("n", "<leader>f", "<Nop>", "检索")
map("n", "<c-p>", "<cmd>Telescope find_files<cr>", "检索文件")
map("n", "<leader><space>", "<cmd>Telescope live_grep<cr>", "模糊的全局搜索")
map(
	"n",
	"<c-/>",
	"<cmd>lua require('telescope.builtin').grep_string()<cr>",
	{ desc = "检索光标下的单词,再过滤选择" }
)
map("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find()<cr>", "Find in current buffer")
map("n", "<leader>fb", "<cmd>Telescope buffers()<cr>", "Find Buffers")
map("n", "<leader>fo", "<cmd>Telescope oldfiles()<cr>", "Find old files")
map("n", "<leader>fc", "<cmd>Telescope colorscheme<cr>", "List Colorscheme")
map("n", "<leader>fp", "<cmd>Telescope projects<cr>", "Find Projects file")
map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", "Todo in Workspace")
map("n", "<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", "Todo/Fix/Fixme in Workspace")
map("n", "<leader>fg", "<Nop>", "Git 检索")
map("n", "<leader>fgf", "<cmd>Telescope git_files<cr>", "Find Git Files")
map("n", "<leader>fgb", "<cmd>Telescope git_branches<cr>", "list git branch")
map("n", "<leader>fgc", "<cmd>Telescope git_commits<cr>", "list git commit")
map("n", "<leader>fgs", "<cmd>Telescope git_status<cr>", "list git status")
map("n", "<leader>fgt", "<cmd>Telescope git_stash<cr>", "list git stash")
map("n", "<leader>l", "<Nop>", "LSP 检索")
map("n", "<leader>li", "<cmd>Telescope lsp_incoming_calls<cr>", "list lsp_incoming_calls")
map("n", "<leader>lo", "<cmd>Telescope lsp_outgoing_calls<cr>", "list lsp_outgoing_calls")
map("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", "list lsp_document_symbols")
map("n", "<leader>lS", "<cmd>Telescope lsp_workspace_symbols<cr>", "list lsp_workspace_symbols")
map("n", "<leader>lw", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "list lsp_dynamic_workspace_symbols")
-- map("n", "<leader>ft", "<cmd>ToggleTerm<cr>", "Terminal")
-- map("n", "<leader>fT", "<cmd>ToggleTerm dir=~ name=root<cr>", "Terminal root")
map("n", "<leader>a", "<cmd>Alpha<cr>", "Welcome")
map("n", "<leader>b", "<Nop>", "Buffer")
map("n", "<leader>bd", "<cmd>Bdelete!<cr>", "Close buffer")
map("n", "<leader>bq", "<cmd>bd<cr>", "Close buffer And Window")
map("n", "<leader>bb", "<cmd>e #<cr>", "swap with last buffer")
map("n", "<leader>bl", "<cmd>BufferLineCloseRight<cr>", "Close Right buffers")
map("n", "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", "Close Left buffers")
map("n", "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", "Close Others buffer")
map("n", "<leader>bc", "<cmd>BufferLinePickClose<cr>", "Pick Buffer Close")
map("n", "<leader>bp", "<cmd>BufferLinePick<cr>", "Pick Buffer")
map("n", "<leader>b,", "<cmd>BufferLineMovePrev<cr>", "Buffer Move Prev")
map("n", "<leader>b.", "<cmd>BufferLineMoveNext<cr>", "Buffer Move Next")
map("n", "<leader>b[", "<cmd>BufferLineCyclePrev<cr>", "Focus Pre Buffer")
map("n", "<leader>b]", "<cmd>BufferLineCycleNext<cr>", "Focus Next Buffer")

map("n", "<leader>g", "<Nop>", "Git")
map("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", "Diff Project") --工作区与暂存区的区别,暂存区与本地git仓库的
map("n", "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", "Current File History") --git本地仓库中,当前文件的commit记录与上次commit之间的区别 ,这个只正对当前文件
map("n", "<leader>gF", "<cmd>DiffviewFileHistory<cr>", "Files History") --git本地仓库中,当前文件的commit记录与上次commit之间的区别,这个是所有文件的
map("n", "<leader>gx", "<cmd>DiffviewClose<cr>", "DiffviewClose")
map("n", "<leader>gn", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk")
map("n", "<leader>gp", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk")
map("n", "]g", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk")
map("n", "[g", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk")
map("n", "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", "提交信息")
map("n", "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk")
map("n", "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer")

local function get_args(config)
	local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
	config = vim.deepcopy(config)
	---@cast args string[]
	config.args = function()
		local new_args = vim.fn.input("Run with args: ", table.concat(args, " ")) --[[@as string]]
		return vim.split(vim.fn.expand(new_args) --[[@as string]], " ")
	end
	return config
end

pluginKeys.whichkeys = {

	{ "<leader>o", group = "Task" },
	{ "<leader>ow", "<cmd>OverseerToggle<cr>", desc = "Task list" },
	{ "<leader>oo", "<cmd>OverseerRun<cr>", desc = "Run task" },
	{ "<leader>oq", "<cmd>OverseerQuickAction<cr>", desc = "Action recent task" },
	{ "<leader>oi", "<cmd>OverseerInfo<cr>", desc = "Overseer Info" },
	{ "<leader>ob", "<cmd>OverseerBuild<cr>", desc = "Task builder" },
	{ "<leader>ot", "<cmd>OverseerTaskAction<cr>", desc = "Task action" },
	{ "<leader>oc", "<cmd>OverseerClearCache<cr>", desc = "Clear cache" },

	{ "<leader>x", group = "Trouble" },
	{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
	{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
	{ "<leader>xs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
	{ "<leader>xS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
	{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
	{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },

	{ "<leader>t", group = "Test" },
	{
		"<leader>ta",
		function()
			require("neotest").run.attach()
		end,
		desc = "[t]est [a]ttach",
	},
	{
		"<leader>tf",
		function()
			require("neotest").run.run(vim.fn.expand("%"))
		end,
		desc = "[t]est run [f]ile",
	},
	{
		"<leader>tA",
		function()
			require("neotest").run.run(vim.uv.cwd())
		end,
		desc = "[t]est [A]ll files",
	},
	{
		"<leader>tS",
		function()
			require("neotest").run.run({ suite = true })
		end,
		desc = "[t]est [S]uite",
	},
	{
		"<leader>tt", --运行当前方法
		function()
			require("neotest").run.run()
		end,
		desc = "[t]est [n]earest",
	},
	{
		"<leader>tl",
		function()
			require("neotest").run.run_last()
		end,
		desc = "[t]est [l]ast",
	},
	{
		"<leader>ts",
		function()
			require("neotest").summary.toggle()
		end,
		desc = "[t]est [s]ummary",
	},
	{
		"<leader>to",
		function()
			require("neotest").output.open({ enter = true, auto_close = true })
		end,
		desc = "[t]est [o]utput",
	},
	{
		"<leader>tO",
		function()
			require("neotest").output_panel.toggle()
		end,
		desc = "[t]est [O]utput panel",
	},
	{
		"<leader>tc",
		function()
			require("neotest").output_panel.clear()
		end,
		desc = "clear [O]utput panel",
	},
	{
		"<leader>te",
		function()
			require("neotest").run.stop()
		end,
		desc = "[t]est [t]erminate",
	},
	{
		"<leader>td",
		function()
			require("neotest").run.run({ suite = false, strategy = "dap" })
		end,
		desc = "Debug nearest test",
	},

	{ "<leader>T", group = "Terminal" },
	{ "<leader>Tn", "<cmd>lua _NODE_TOGGLE()<cr>", desc = "Node" },
	{ "<leader>Tu", "<cmd>lua _NCDU_TOGGLE()<cr>", desc = "NCDU" },
	{ "<leader>Tt", "<cmd>lua _HTOP_TOGGLE()<cr>", desc = "Htop" },
	{ "<leader>Tp", "<cmd>lua _PYTHON_TOGGLE()<cr>", desc = "Python" },
	{ "<leader>Tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float" },
	{ "<leader>Th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Horizontal" },
	{ "<leader>Tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical" },

	{ "<leader>h", group = "Help" },
	{ "<leader>hc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
	{ "<leader>hh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
	{ "<leader>hM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
	{ "<leader>hR", "<cmd>Telescope registers<cr>", desc = "Registers" },
	{ "<leader>hk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
	{ "<leader>hC", "<cmd>Telescope commands<cr>", desc = "Commands" },
	{ "<leader>ha", "<cmd>lua require('telescope.builtin').autocommands()<cr>", desc = "Find  au" },

	{ "<leader>z", "<cmd>ZenMode<cr>", desc = "ZenMode" },
}

map("n", ",o", "<cmd>Outline<CR>", "Outline")
-- map("n", "<leader>/", "<cmd>OutlineFocus<CR>", "OutlineFocus")

-- 黑苹果不支持,m1芯片是支持的 zellij 0.43.1 支持,0.44有bug
map({ "n", "i", "v" }, "<D-s>", function()
	vim.cmd("silent! write")
end, "save")

-- 桥接使用,因为黑苹果不支持上面的<D-s>,又不d想使用:w的方式,因为想屏蔽小命令行
-- map({ "n", "i", "v" }, "<F14>", function()
-- 	log("ted<F14>st")
-- 	vim.cmd("silent! write")
-- end, "save")

map({ "n", "i", "v" }, "<F15>", function()
	vim.cmd("silent! NvimTreeFindFile")
end, "NvimTreeFindFile")

map({ "n", "v" }, "<Leader>sr", function()
	local grug = require("grug-far")
	local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
	grug.open({
		transient = true,
		prefills = {
			filesFilter = ext and ext ~= "" and "*." .. ext or nil,
		},
	})
end, "Search and Replace")

-- lsp
map("n", "gci", "<cmd>LspInfo<cr>", "Lsp Info") --show lsp info
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition")
map("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto Implementation")
map("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition")
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "Goto Declaration")
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover")
map("n", "gK", "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help")
map("i", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help")
map("n", ",rn", "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename")
map({ "n", "v" }, "gca", "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action")
map("n", "gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
map("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>")
map("n", ",gr", "<cmd>TroubleToggle lsp_references<cr>")
map("n", "gr", "<cmd>Telescope lsp_references<cr>")
-- -- map("n", "<leader><leader>", function()
-- 	require("conform").format({ async = false })
-- end, opts("Format"))

-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp, has_words_before, feedkey)
	local luasnip = require("luasnip")
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
		-- 【关键修复】：配置 Tab 键逻辑
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				-- 1. 如果补全菜单可见，选择下一个
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				-- 2. 【核心】如果处于 Snippet 中且可以跳转，则跳转到下一个占位符
				luasnip.expand_or_jump()
			else
				fallback() -- 否则执行默认 Tab 行为（缩进）
			end
		end, { "i", "s" }), -- 注意这里要包含 "s" (select mode)，因为占位符通常处于选中状态

		-- 配置 Shift+Tab 往回跳
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}
end

-- dap
pluginKeys.DAPTmpunmap = function()
	unmap("n", ",dg", {})
	unmap("n", ",dG", {})
	unmap("n", ",dr", {})
	unmap("n", ",dR", {})
	unmap("n", "<F10>", {})
	unmap("n", "<F11>", {})
	unmap("n", "<F12>", {})

	unmap("n", ",di", {})
	unmap("n", ",do", {})
	unmap("n", "<cr>", {})
	unmap("n", "<leader><cr>", {})
	unmap("n", ",dl", {})
	unmap("n", ",dp", {})
	unmap("n", ",ds", {})
	unmap("n", ",de", {})
	unmap("n", ",du", {})
	unmap({ "n", "v" }, ",dh", {})
	unmap("n", ",dS", {})
	unmap({ "n", "v" }, ",dE", {})
end

pluginKeys.DAPmap = function()
	map("n", "<F5>", function()
		require("dap").continue()
	end, { desc = "启动断点" })

	map("n", ",da", function()
		require("dap").continue({ before = get_args })
	end, { desc = "Run with Args" })

	map("n", ",dd", function()
		require("dap").toggle_breakpoint()
	end, { desc = "Toggle Breakpoint" })
	--设置条件断点
	map("n", ",dD", function()
		-- require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
		require("dap").set_breakpoint(vim.fn.input("[Condition] > ")) -- 输入条件eg: a>18
	end, { desc = "设置条件断点" })
	--清空所有断点
	map("n", ",dc", function()
		require("dap").clear_breakpoints()
	end, { desc = "clear all breakpoints" })
end

pluginKeys.DAPTmpmap = function()
	map("n", ",dg", function()
		require("dap").run_to_cursor()
	end, { desc = "Run to Cursor" })

	map("n", ",dG", function()
		require("dap").goto_()
	end, { desc = "Go to Line (No Execute)" })
	map("n", ",dr", function()
		require("dap").repl.toggle()
	end, { desc = "Toggle REPL" })
	map("n", ",dR", function()
		require("dap").restart()
	end, { desc = "restart" })
	--  stepOver, stepOut, stepInto
	map("n", "<F10>", ":lua require'dap'.step_over()<CR>")
	map("n", "<F11>", ":lua require'dap'.step_into()<CR>")
	map("n", "<F12>", ":lua require'dap'.step_out()<CR>")

	map("n", ",di", function()
		require("dap").step_into()
	end, { desc = "Step Into" })

	map("n", ",do", function()
		require("dap").step_out()
	end, { desc = "Step Out" })

	map("n", "<cr>", function()
		require("dap").step_over() -- 单步
	end, { desc = "Step Over" })

	map("n", "<leader><cr>", function()
		require("dap").step_back() -- 单步回退,需要debugger支持才能用
	end, { desc = "Step Back" })

	map("n", ",dl", function()
		require("dap").run_last()
	end, { desc = "Run Last" })

	map("n", ",dp", function()
		require("dap").pause()
	end, { desc = "Pause" })

	map("n", ",ds", function()
		require("dap").session()
	end, { desc = "Session" })

	--结束调试
	map("n", ",de", function()
		require("dap").terminate()
	end, { desc = "Terminate", silent = true })

	map({ "n", "v" }, ",dh", function()
		require("dap.ui.widgets").hover()
	end, { desc = "hover" })

	map("n", ",du", function()
		require("dap").toggle({})
	end, { desc = "Dap UI", silent = true })

	map("n", ",dS", function()
		local widgets = require("dap.ui.widgets")
		widgets.centered_float(widgets.frames) --将栈信息显示在屏幕中间
	end, { desc = "show stack info" })

	map({ "n", "v" }, ",dE", function()
		require("dapui").eval()
	end, { desc = "Eval" })
end

pluginKeys.mapFanYi = function()
	map("n", "fy", "<cmd>TransToZH<CR>")
end

pluginKeys.mapGo = function()
	-- vim.cmd("au FileType go nmap <buffer> <silent> <LocalLeader>r :GoRun -F %:p:h<cr>")
	-- vim.cmd([[au FileType go nmap <buffer> <silent> <LocalLeader>r :execute 'GoRun -F ./' . expand('%:h')<CR>]])
	-- vim.cmd([[au FileType go nmap <buffer> <silent> <LocalLeader>r :execute 'GoRun -F ./' . fnamemodify(expand('%'), ':.:h')<CR>]])

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "go",
		callback = function()
			vim.keymap.set("n", "<LocalLeader>r", function()
				-- 核心修正：fnamemodify(..., ":.:h")
				-- :.  表示相对于当前 CWD (Current Working Directory)
				-- :h  表示取目录头
				local relative_dir = vim.fn.fnamemodify(vim.fn.expand("%"), ":.:h")

				-- 拼接成 ./test/slog
				local cmd = "GoRun -F ./" .. relative_dir

				vim.cmd(cmd)
				print("Running: " .. cmd) -- 打印出来，让你看到这次跑的是对的
			end, { buffer = true, silent = true, desc = "Go Run Relative" })
		end,
	})

	-- vim.cmd("au FileType go nmap <buffer> <LocalLeader>b :GoBuild -o cc %:p:h<cr>")
	vim.cmd("au FileType go nmap <buffer> <LocalLeader>b :!go build -o /tmp/ %:p:h<cr>")
	vim.cmd("au FileType go nmap <buffer> <LocalLeader>tb :GoAddTag bson<cr>")
	vim.cmd("au FileType go nmap <buffer> <LocalLeader>tj :GoAddTag json<cr>")
	-- vim.cmd("au FileType go nmap <buffer> <LocalLeader>tt :GoAddTag toml<cr>")
	vim.cmd("au FileType go nmap <buffer> <LocalLeader>ty :GoAddTag yaml<cr>")
	vim.cmd("au FileType go nmap <buffer> <LocalLeader>tx :GoAddTag xml<cr>")
	vim.cmd("au FileType go nmap <buffer> <LocalLeader>tc :GoClearTag <cr>")

	vim.cmd("au FileType go nmap <buffer> <LocalLeader>tg :GoTests<cr>")
end

pluginKeys.mapJavascript = function()
	vim.cmd("au FileType javascript nmap <buffer> <silent> <LocalLeader>r :!node  %<cr>")
	vim.cmd("au FileType typescript nmap <buffer> <silent> <LocalLeader>r :!ts-node  %<cr>")
end

vim.cmd("au FileType lua nmap <buffer> <silent> <LocalLeader>r :!lua  %<cr>")

pluginKeys.accelerated = function()
	map("n", "j", "<Plug>(accelerated_jk_gj)")
	map("n", "k", "<Plug>(accelerated_jk_gk)")
end

pluginKeys.mapTerminal = function()
	vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
	map({ "n", "o" }, "<F13>", [[<cmd>lua _BottomTerminal_TOGGLE() <cr>]])
end

return pluginKeys
