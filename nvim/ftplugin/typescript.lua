-- 确保这是一个 Go 文件
if vim.bo.filetype ~= "typescript" then
	return
end

-- 防止重复加载
if vim.b.did_ftplugin_ts then
	return
end
vim.b.did_ftplugin_ts = true

-- 运行当前文件
vim.api.nvim_buf_set_keymap(0, "n", "<LocalLeader>r", ":!ls -lah", { noremap = true, silent = true })
