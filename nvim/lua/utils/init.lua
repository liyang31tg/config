function _G.log(...)
	local msg = vim.inspect({ ... }) -- 自动格式化任何变量
	vim.notify(msg, vim.log.levels.INFO) -- 右上角弹出通知
	print("[LOG]", msg) -- 命令行 :messages 里也能看到
end

function _G.map(mode, lhs, rhs, opts)
	local default_opts = { remap = false, silent = true, unique = false }
	if type(opts) == "string" then
		opts = { desc = opts }
	end
	if type(opts) == "number" then
		opts = { buf = opts }
	end
	opts = vim.tbl_extend("force", default_opts, opts or {})
	vim.keymap.set(mode, lhs, rhs, opts)
end

function _G.unmap(mode, lhs, opts)
	if type(opts) == "number" then
		opts = { buf = opts }
	end
	opts = opts or {}
	pcall(vim.keymap.del, mode, lhs, opts)
end
