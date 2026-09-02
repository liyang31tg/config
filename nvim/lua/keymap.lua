--第三方插件的快捷键银蛇如下
local pluginKeys = {}
pluginKeys.whichkeys = {}

--- 向 which-key 注册一条映射/展示条目（统一入口）
---
--- 行为约定：
---   - 传入 rhs 时，which-key 会通过 vim.keymap.set 创建真实映射
---   - 不传 rhs（nil）时，仅作为展示条目（group/占位），不占用真实键位
---   - opts 为字符串时，等价于 { desc = opts }
---
---@param mode string|string[] 模式，同 vim.keymap.set 第一个参数；如 "n" 或 {"n","v"}。可不传
---@param lhs string 触发键（映射左侧），如 "<leader>bp"
---@param rhs string|fun()? 映射内容（右侧）；为 nil 时只展示、不创建映射
---@param opts string|table? 字符串时为描述 desc；表时为 which-key 的 wk.Spec 选项（desc/group/icon/hidden/cond/...）
---   opts 内也会自动合并 remap=false、silent=true、unique=false 默认值
local function mapwk(mode, lhs, rhs, opts)
	local t = { [1] = lhs }
	if rhs ~= nil then
		t[2] = rhs
	end
	if type(opts) == "string" then
		opts = { desc = opts }
	else
		opts = opts or {}
	end
	if mode ~= nil then
		opts.mode = mode
	end
	local default_opts = { remap = false, silent = true, unique = false }
	opts = vim.tbl_extend("force", default_opts, opts or {})
	table.insert(pluginKeys.whichkeys, vim.tbl_extend("force", t, opts))
end

-- unmap("n", "gc")
-- unmap("n", "gcc")
--默认行为有个:tag的意思,容易引起误会
-- map("n", "<c-t>", "<Nop>")
--莫名多一个空格,用原生实现
map("n", "\\s", ":<c-u>%s//g<left><left>", { silent = false, desc = "文本替换" })
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", "Escape and Clear hlsearch")

-- 修改搜索的时候{n/N}的行为，默认行为，这2个命令的方式是根据/?的搜索来决定的
-- map({ "n", "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "下一个搜索" })

map({ "n", "x", "o" }, "n", function()
	if vim.v.searchforward == 1 then
		return "n"
	else
		return "N"
	end
end, { expr = true, desc = "下一个搜索" })
-- map({ "n", "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "上一个搜索" })
map({ "n", "x", "o" }, "N", function()
	if vim.v.searchforward == 1 then
		return "N"
	else
		return "n"
	end
end, { expr = true, desc = "上一个搜索(逆向搜索)" })

-- windows 分屏快捷键
map("n", "sh", "<cmd>vsp<cr><c-w>h", "左边分屏")
map("n", "sj", "<cmd>sp<cr>", "下边分屏")
map("n", "sk", "<cmd>sp<cr><c-w>k", "上边分屏")
map("n", "sl", "<cmd>vsp<cr>", "右边分屏")
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
map("v", "J", ":move '>+1<cr>gv", "Move down") --不需要缩进,所以删掉了gv=gv,help gv 选中上一次可视区域
map("v", "K", ":move '<-2<cr>gv", "Move up")
map("v", "L", ">gv", "Move right")
map("v", "H", "<gv", "Move left")

-- barbar
-- 左右Tab切换

-- 修复diff对齐点,很少用
map("n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", "Redraw / clear hlsearch / diff update")

map("c", "<c-a>", function()
	local line = vim.fn.getcmdline()
	local pos = line:match("^%s*()") or 1
	vim.fn.setcmdpos(pos)
end, { desc = "Home (first non-blank)" })
map("c", "<c-b>", "<Left>", { silent = false, desc = "Left" })
map("c", "<c-d>", "<Del>", { silent = false, desc = "Del" })
map("c", "<c-e>", "<End>", { silent = false, desc = "End" })
map("c", "<c-f>", "<Right>", { silent = false, desc = "Right" })
map("c", "<c-N>", "<Down>", { silent = false, desc = "Down" })
map("c", "<c-P>", "<Up>", { silent = false, desc = "Up" })
-- map("c", "<esc><c-b>", "<S-Left>", { silent = false, desc = "S-left" })
-- map("c", "<esc><c-f>", "<S-right>", { silent = false, desc = "S-right" })

map("c", "<c-k>", function()
	local pos = vim.fn.getcmdpos()
	local line = vim.fn.getcmdline()
	vim.fn.setcmdline(line:sub(1, pos - 1))
end, { silent = false, desc = "命令行删除光标后所有字符" })

--keywordprg
map("n", "<leader>K", "<cmd>normal! K<cr>", { desc = "Keywordprg 查询文档,K的内置作用" })

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

-- 在visual 模式里粘贴不要复制
map("x", "p", '"_dP')
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
map("i", "<c-a>", "<C-o>^", { desc = "Home (first non-blank)" })
map({ "i", "c" }, "<c-e>", "<end>")
map("c", "<c-a>", "<home>")

--nvim-tree
map({ "n", "i", "v", "c", "t" }, "<c-0>", "<cmd>NvimTreeFindFile<CR>")
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", "Explorer")

map("n", "]t", function()
	require("todo-comments").jump_next()
end, "Next Todo Comment in current buffer")

map("n", "[t", function()
	require("todo-comments").jump_prev()
end, "Previous Todo Comment in current buffer")

map("n", "<c-p>", "<cmd>Telescope find_files<cr>", "检索文件")
map("n", "<c-b>", "<cmd>Telescope buffers<cr>", "检索buffers")
map("n", "<leader><space>", "<cmd>Telescope live_grep<cr>", "模糊的全局搜索")
map({ "n", "v" }, "<c-s-8>", function() --<c-*>
	require("telescope.builtin").grep_string()
end, "检索光标下的单词,再过滤选择")
--MARK: <leader>f
mapwk("n", "<leader>f", nil, { group = "检索", icon = "🔍" })
map("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", "fuzzy Find in current buffer")
map("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", "Find old files")
map("n", "<leader>fc", "<cmd>Telescope commands<cr>", "List commands")
map("n", "<leader>fcc", "<cmd>Telescope colorscheme<cr>", "List Colorscheme")
map("n", "<leader>fp", "<cmd>Telescope projects<cr>", "Find Projects file")
map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", "Keymaps")
map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", "Todo in Workspace")
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", "Find Help")
map("n", "<leader>fm", "<cmd>Telescope man_pages<cr>", "Man Pages")
map("n", "<leader>fr", "<cmd>Telescope registers<cr>", "show Registers")
map("n", "<leader>fa", "<cmd>Telescope autocommands<cr>", "show aucommands")

map("n", "<leader>z", "<cmd>ZenMode<cr>", "ZenMode")

mapwk("n", "<leader>l", nil, { group = "LSP 检索" })
map("n", "<leader>li", "<cmd>Telescope lsp_incoming_calls<cr>", "谁调用了我")
map("n", "<leader>lo", "<cmd>Telescope lsp_outgoing_calls<cr>", "我调用了谁")
map("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", "list lsp_document_symbols")
map("n", "<leader>lS", "<cmd>Telescope lsp_workspace_symbols<cr>", "list lsp_workspace_symbols")
map("n", "<leader>lw", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "list lsp_dynamic_workspace_symbols")

map("n", "<leader>a", "<cmd>Alpha<cr>", "Welcome")

mapwk("n", "<leader>b", nil, { group = "Buffer" })
map("n", "<leader>bq", "<cmd>BufferClose<cr>", "Close buffer")
map("n", "<leader>bd", "<cmd>BufferPickDelete<cr>", "Pick Delete")
map("n", "<leader>bo", "<cmd>BufferCloseAllButCurrent<cr>", "Close Others buffer")
map("n", "<leader>bh", "<cmd>BufferCloseBuffersLeft<cr>", "Close Left buffers")
map("n", "<leader>bl", "<cmd>BufferCloseBuffersRight<cr>", "Close Right buffers")
map("n", "<leader>bv", "<cmd>BufferCloseAllButVisible<cr>", "BufferCloseAllButVisible")
map("n", "<leader>bcc", "<cmd>BufferCloseAllButCurrentOrPinned<cr>", "Buffer Close 除了pinned and current")
map("n", "<leader>bcp", "<cmd>BufferCloseAllButPinned<cr>", "Buffer Close 除了pinned")
map("n", "<leader>bp", "<cmd>BufferPin<cr>", "Pick Buffer")
map("n", "[b", "<cmd>BufferPrevious<cr>", "Previous Buffer")
map("n", "]b", "<cmd>BufferNext<cr>", "Next Buffer")
map("n", "<leader>b,", "<cmd>BufferMovePrevious<cr>", "BufferMovePrevious")
map("n", "<leader>b.", "<cmd>BufferMoveNext<cr>", "BufferMoveNext")
for i = 1, 9 do
	map("n", string.format("<leader>%d", i), string.format("<cmd>BufferGoto %d<cr>", i), {
		desc = string.format("BufferGoto %d", i),
	})
end

mapwk("n", "<leader>g", nil, { group = "+Git" })
map("n", "<leader>gg", "<cmd>Telescope git_files<cr>", "Find Git Files")
map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", "list git branch")
map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", "list git commit")
map("n", "<leader>gs", "<cmd>Telescope git_status<cr>", "list git status")
map("n", "<leader>gt", "<cmd>Telescope git_stash<cr>", "list git stash")
map("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", "Diff Project.") --默认工作区与暂存区的区别,暂存区与本地git仓库的.当然通过命令可以工作区与commit之间的比较. eg: DiffviewOpen main
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", "Current File History") --git本地仓库中,当前文件的commit记录与上次commit之间的区别 ,这个只正对当前文件
map("n", "<leader>gH", "<cmd>DiffviewFileHistory<cr>", "Files History") --git本地仓库中,当前文件的commit记录与上次commit之间的区别,这个是所有文件的
map("n", "<leader>gx", "<cmd>DiffviewClose<cr>", "DiffviewClose")
map("n", "<leader>gn", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk")
map("n", "<leader>gp", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk")
map("n", "]g", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk")
map("n", "[g", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk")
map("n", "<leader>gl", "<cmdd>lua require 'gitsigns'.blame_line()<cr>", "提交信息")
map("n", "<leader>gr", "<cmdd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk")
map("n", "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Hunk in Buffer")

--telescope 有功能交叉,区别在于telescope是一次性访问,会弹出一个弹窗.这个只会在旁边新开一个buffer来持久显示
mapwk("n", "<leader>x", nil, { group = "Trouble" })
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", "Diagnostics (Trouble)")
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Buffer Diagnostics (Trouble)")
map("n", "<leader>xi", "<cmd>Trouble lsp_incoming_calls toggle<cr>", "谁调用了我")
map("n", "<leader>xo", "<cmd>Trouble lsp_outgoing_calls toggle<cr>", "我调用了谁")
map("n", "<leader>xs", "<cmd>Trouble lsp_document_symbols toggle<cr>", "当前buffer的symbols")

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

-- pluginKeys.whichkeys = {
-- 	{ "<leader>o", group = "Task" },
-- 	{ "<leader>ow", "<cmd>OverseerToggle<cr>", desc = "Task list" },
-- 	{ "<leader>oo", "<cmd>OverseerRun<cr>", desc = "Run task" },
-- 	{ "<leader>oq", "<cmd>OverseerQuickAction<cr>", desc = "Action recent task" },
-- 	{ "<leader>oi", "<cmd>OverseerInfo<cr>", desc = "Overseer Info" },
-- 	{ "<leader>ob", "<cmd>OverseerBuild<cr>", desc = "Task kbuilder" },
-- 	{ "<leader>ot", "<cmd>OverseerTaskAction<cr>", desc = "Task action" },
-- 	{ "<leader>oc", "<cmd>OverseerClearCache<cr>", desc = "Clear cache" },
--
-- 	{ "<leader>t", group = "Test" },
-- 	{
-- 		"<leader>ta",
-- 		function()
-- 			require("neotest").run.attach()
-- 		end,
-- 		desc = "[t]est [a]ttach",
-- 	},
-- 	{
-- 		"<leader>tf",
-- 		function()
-- 			require("neotest").run.run(vim.fn.expand("%"))
-- 		end,
-- 		desc = "[t]est run [f]ile",
-- 	},
-- 	{
-- 		"<leader>tA",
-- 		function()
-- 			require("neotest").run.run(vim.uv.cwd())
-- 		end,
-- 		desc = "[t]est [A]ll files",
-- 	},
-- 	{
-- 		"<leader>tS",
-- 		function()
-- 			require("neotest").run.run({ suite = true })
-- 		end,
-- 		desc = "[t]est [S]uite",
-- 	},
-- 	{
-- 		"<leader>tt", --运行当前方法
-- 		function()
-- 			require("neotest").run.run()
-- 		end,
-- 		desc = "[t]est [n]earest",
-- 	},
-- 	{
-- 		"<leader>tl",
-- 		function()
-- 			require("neotest").run.run_last()
-- 		end,
-- 		desc = "[t]est [l]ast",
-- 	},
-- 	{
-- 		"<leader>ts",
-- 		function()
-- 			require("neotest").summary.toggle()
-- 		end,
-- 		desc = "[t]est [s]ummary",
-- 	},
-- 	{
-- 		"<leader>to",
-- 		function()
-- 			require("neotest").output.open({ enter = true, auto_close = true })
-- 		end,
-- 		desc = "[t]est [o]utput",
-- 	},
-- 	{
-- 		"<leader>tO",
-- 		function()
-- 			require("neotest").output_panel.toggle()
-- 		end,
-- 		desc = "[t]est [O]utput panel",
-- 	},
-- 	{
-- 		"<leader>tc",
-- 		function()
-- 			require("neotest").output_panel.clear()
-- 		end,
-- 		desc = "clear [O]utput panel",
-- 	},
-- 	{
-- 		"<leader>te",
-- 		function()
-- 			require("neotest").run.stop()
-- 		end,
-- 		desc = "[t]est [t]erminate",
-- 	},
-- 	{
-- 		"<leader>td",
-- 		function()
-- 			require("neotest").run.run({ suite = false, strategy = "dap" })
-- 		end,
-- 		desc = "Debug nearest test",
-- 	},
--
-- 	{ "<leader>T", group = "Terminal" },
-- 	{ "<leader>Tn", "<cmd>lua _NODE_TOGGLE()<cr>", desc = "Node" },
-- 	{ "<leader>Tu", "<cmd>lua _NCDU_TOGGLE()<cr>", desc = "NCDU" },
-- 	{ "<leader>Tt", "<cmd>lua _HTOP_TOGGLE()<cr>", desc = "Htop" },
-- 	{ "<leader>Tp", "<cmd>lua _PYTHON_TOGGLE()<cr>", desc = "Python" },
-- 	{ "<leader>Tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float" },
-- 	{ "<leader>Th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Horizontal" },
-- 	{ "<leader>Tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical" },
-- }

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
map({ "n", "v" }, "gra", "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action")
map("n", "gri", "<cmd>Telescope lsp_implementations<CR>", "Goto Implementation") --lua vim.lsp.buf.implementation()
map("n", "grn", "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename")
map("n", "gr", "<cmd>Telescope lsp_references<cr>") --<cmd>Trouble lsp_references<cr>
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition")
map("n", "gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition")
map("n", "gO", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", "Goto document_symbol") --gx 进入文档链接
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover") --hover 不能识别你正在输入第几个参数；
map("i", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help") --signature_help 专门服务「边写参数边看形参」这个编码场景；
map("n", "gh", "<cmd>lua vim.lsp.buf.declaration()<CR>", "Goto Declaration")

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
	map("n", ",dc", function()
		-- require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
		require("dap").set_breakpoint(vim.fn.input("[Condition] > ")) -- 输入条件eg: a>18
	end, { desc = "设置条件断点(只能可见当前函数帧里面的变量,全局变量也看不到)" })
	--清空所有断点
	map("n", ",dx", function()
		require("dap").clear_breakpoints()
	end, { desc = "clear all breakpoints" })
end

-- 调试期间保存/恢复全局快捷键，避免覆盖已有映射
local dap_saved_maps = {}
local dap_debug_keys = {
	{ "n", ",dg" },
	{ "n", ",dG" },
	{ "n", ",dr" },
	{ "n", ",dR" },
	{ "n", "<F10>" },
	{ "n", "<F11>" },
	{ "n", "<F12>" },
	{ "n", ",di" },
	{ "n", ",do" },
	{ "n", ",dl" },
	{ "n", ",dp" },
	{ "n", ",ds" },
	{ "n", ",de" },
	{ "n", ",du" },
	{ "n", ",dS" },
	{ "n", ",dh" },
	{ "v", ",dh" },
	{ "n", ",dE" },
	{ "v", ",dE" },
}

pluginKeys.DAPTmpmap = function()
	dap_saved_maps = {}
	for _, k in ipairs(dap_debug_keys) do
		local mode, lhs = k[1], k[2]
		local existing = vim.fn.maparg(lhs, mode, false, true)
		if existing and existing.lhs then
			dap_saved_maps[mode .. ":" .. lhs] = existing
		end
	end

	local opts = { noremap = true, silent = true }

	vim.keymap.set("n", ",dg", function()
		require("dap").run_to_cursor()
	end, opts)

	vim.keymap.set("n", ",dG", function()
		require("dap").goto_()
	end, opts)

	vim.keymap.set("n", ",dr", function()
		require("dap").repl.toggle()
	end, opts)

	vim.keymap.set("n", ",dR", function()
		require("dap").restart()
	end, opts)

	vim.keymap.set("n", "<F10>", function()
		require("dap").step_over()
	end, opts)

	vim.keymap.set("n", "<F11>", function()
		require("dap").step_into()
	end, opts)

	vim.keymap.set("n", "<F12>", function()
		require("dap").step_out()
	end, opts)

	vim.keymap.set("n", ",di", function()
		require("dap").step_into()
	end, opts)

	vim.keymap.set("n", ",do", function()
		require("dap").step_out()
	end, opts)

	vim.keymap.set("n", ",dl", function()
		require("dap").run_last()
	end, opts)

	vim.keymap.set("n", ",dp", function()
		require("dap").pause()
	end, opts)

	vim.keymap.set("n", ",ds", function()
		require("dap").session()
	end, opts)

	vim.keymap.set("n", ",de", function()
		require("dap").terminate()
	end, opts)

	vim.keymap.set({ "n", "v" }, ",dh", function()
		require("dap.ui.widgets").hover()
	end, opts)

	vim.keymap.set("n", ",du", function()
		require("dap").toggle({})
	end, opts)

	vim.keymap.set("n", ",dS", function()
		local widgets = require("dap.ui.widgets")
		widgets.centered_float(widgets.frames)
	end, opts)

	vim.keymap.set({ "n", "v" }, ",dE", function()
		require("dapui").eval()
	end, opts)
end

pluginKeys.DAPTmpunmap = function()
	for _, k in ipairs(dap_debug_keys) do
		local mode, lhs = k[1], k[2]
		pcall(vim.keymap.del, mode, lhs)
		local saved = dap_saved_maps[mode .. ":" .. lhs]
		if saved then
			local restore_opts = {}
			if saved.silent == 1 then
				restore_opts.silent = true
			end
			if saved.noremap == 1 then
				restore_opts.noremap = true
			end
			if saved.expr == 1 then
				restore_opts.expr = true
			end
			if saved.desc and saved.desc ~= "" then
				restore_opts.desc = saved.desc
			end
			if saved.callback then
				vim.keymap.set(mode, lhs, saved.callback, restore_opts)
			else
				vim.keymap.set(mode, lhs, saved.rhs, restore_opts)
			end
		end
	end
	dap_saved_maps = {}
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
