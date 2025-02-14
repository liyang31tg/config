local opt = vim.opt --等价于 set opt = value
local optlocal = vim.opt_local --等价于 setlocal opt = value
local buffer = vim.b
local global = vim.g

-- 启用文件类型插件和基于文件类型的缩进规则
vim.cmd("filetype plugin indent on")

-- 将文本宽度设置为 0，禁用自动换行
opt.textwidth = 0

-- 清空缩进表达式
opt.indentexpr = ""

-- 将折叠方法设置为基于缩进
opt.foldmethod = "indent"

-- 将折叠级别设置为 99，展开所有折叠块
opt.foldlevel = 99

-- 始终显示状态行
opt.laststatus = 2

-- 设置 tab 为 4 个空格
opt.tabstop = 4

-- 将 tab 展开为空格
opt.expandtab = true

-- 使用增强状态栏插件后不再需要 vim 的模式提示
opt.showmode = false
-- option.backspace = { "indent", "eol", "start" }

-- 缩进2个空格等于一个Tab
opt.shiftwidth = 4
opt.softtabstop = 4

opt.shiftround = true
-- 新行对齐当前行
opt.autoindent = true
opt.smartindent = true
-- 共享unnamedplus "支持系统粘贴板
opt.clipboard = "unnamed,unnamedplus"
-- 使用相对行号
opt.number = true
opt.relativenumber = true
-- 补全增强
opt.wildmenu = true
-- 搜索不要高亮
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true --[[ 只能大小写 ]]
-- 自动补全不自动选中
opt.completeopt = "menu,menuone,noselect,noinsert"
-- 高亮所在行
opt.cursorline = true
opt.termguicolors = true
-- 显示左侧图标指示列
opt.signcolumn = "yes"
-- 当文件被外部程序修改时，自动加载
opt.autoread = true
opt.title = true
-- 鼠标支持
opt.mouse = "a"
-- 禁止创建备份文件
opt.backup = false
opt.writebackup = false
opt.swapfile = false
-- smaller updatetime
opt.updatetime = 50
-- 设置 timeoutlen 为等待键盘快捷键连击时间500毫秒，可根据需要设置
opt.timeoutlen = 500
-- 序列化undofile,保证其文件退出也可以undo
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.config/nvim/.undodir" --将其设置为隐藏文件
--为每一个工作目录创建一个.nvim.lua的隐藏文件,里面可以覆写一些本地配置
opt.exrc = true
-- 禁止折行
opt.wrap = false
-- split window 从下边和右边出现
opt.splitbelow = true
opt.splitright = true
-- 边输入边搜索
opt.incsearch = true
-- jkhl 移动时光标周围保留8行
opt.scrolloff = 8
opt.sidescrolloff = 8
-- 右侧参考线，超过表示代码太长了，考虑换行
--vim.wo.colorcolumn = "80"
-- 命令行高为2，提供足够的显示空间
opt.cmdheight = 1
-- 光标在行首尾时<Left><Right>可以跳到下一行
opt.whichwrap = "<,>,[,]"
-- 允许隐藏被修改过的buffer
opt.hidden = true
-- 样式
opt.background = "dark"
-- 不可见字符的显示，这里只把空格显示为一个点,就是把缩进的空格全部用>占用了
-- option.list = true
--
--vim.o.listchars = "space:·"
-- Dont' pass messages to |ins-completin menu|
opt.shortmess = vim.o.shortmess .. "c"
-- 补全最多显示10行
opt.pumheight = 10
-- 永远显示 tabline
opt.showtabline = 2
opt.showcmd = true

-- buffer
buffer.encoding = "UTF-8"
buffer.fileencoding = "utf-8"

--global
global.mapleader = " "
-- global.maplocalleader = ","
