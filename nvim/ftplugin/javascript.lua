-- 确保这是一个 Go 文件
if vim.bo.filetype ~= "javascript" then
	return
end

-- 防止重复加载
if vim.b.did_ftplugin_js then
	return
end
vim.b.did_ftplugin_js = true

-- 运行当前文件
vim.api.nvim_buf_set_keymap(0, "n", "<LocalLeader>r", ":!ls", { noremap = true, silent = true })
