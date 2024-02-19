-- vim.o 设置普通属性
-- vim.g 设置全局属性
-- vim.bo 设置buffer属性
-- vim.wo 设置窗口属性
-- vim.opt 上面的所有域全设置
local option = vim.opt
local buffer = vim.b
local global = vim.g

-- 使用增强状态栏插件后不再需要 vim 的模式提示
option.showmode = false
option.backspace = { "indent", "eol", "start" }

-- 缩进2个空格等于一个Tab
-- vim.o.ts = 4
-- vim.bo.ts = 4
option.tabstop = 4
option.shiftwidth = 4
option.softtabstop = 4
-- 空格替代tab
option.expandtab = true
option.shiftround = true
-- 新行对齐当前行
option.autoindent = true
option.smartindent = true
-- 共享unnamedplus "支持系统粘贴板
option.clipboard:append({ "unnamed", "unnamedplus" })
-- 使用相对行号
option.number = true
option.relativenumber = true
-- 补全增强
option.wildmenu = true
-- 搜索不要高亮
option.hlsearch = false
option.ignorecase = true
option.smartcase = true --[[ 只能大小写 ]]
-- 自动补全不自动选中
option.completeopt = "menu,menuone,noselect,noinsert"
-- 高亮所在行
option.cursorline = true
option.termguicolors = true
-- 显示左侧图标指示列
option.signcolumn = "yes"
-- 当文件被外部程序修改时，自动加载
option.autoread = true
option.title = true
-- 鼠标支持
option.mouse = "a"
-- 禁止创建备份文件
option.backup = false
option.writebackup = false
option.swapfile = false
-- smaller updatetime
option.updatetime = 50
-- 设置 timeoutlen 为等待键盘快捷键连击时间500毫秒，可根据需要设置
option.timeoutlen = 500
-- 序列化undofile,保证其文件退出也可以undo
option.undofile = true
option.undodir = os.getenv("HOME") .. "/.config/nvim/.undodir" --将其设置为隐藏文件
--为每一个工作目录创建一个.nvim.lua的隐藏文件,里面可以覆写一些本地配置
option.exrc = true
-- 禁止折行
option.wrap = false
-- split window 从下边和右边出现
option.splitbelow = true
option.splitright = true
-- 边输入边搜索
option.incsearch = true
-- jkhl 移动时光标周围保留8行
option.scrolloff = 8
option.sidescrolloff = 8
-- 右侧参考线，超过表示代码太长了，考虑换行
--vim.wo.colorcolumn = "80"
-- 命令行高为2，提供足够的显示空间
option.cmdheight = 1
-- 光标在行首尾时<Left><Right>可以跳到下一行
option.whichwrap = "<,>,[,]"
-- 允许隐藏被修改过的buffer
option.hidden = true
-- 样式
option.background = "dark"
-- 不可见字符的显示，这里只把空格显示为一个点
option.list = true
--vim.o.listchars = "space:·"
-- Dont' pass messages to |ins-completin menu|
option.shortmess = vim.o.shortmess .. "c"
-- 补全最多显示10行
option.pumheight = 10
-- 永远显示 tabline
option.showtabline = 2
option.showcmd = true

-- buffer
buffer.encoding = "UTF-8"
buffer.fileencoding = "utf-8"

--global
global.mapleader = " "
global.maplocalleader = ","
