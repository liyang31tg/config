function _G.log(...)
	local msg = vim.inspect({ ... }) -- 自动格式化任何变量
	vim.notify(msg, vim.log.levels.INFO) -- 右上角弹出通知
	print("[LOG]", msg) -- 命令行 :messages 里也能看到
end

require("opt")
require("keymap")
require("lazy_init")
require("autocmd")
