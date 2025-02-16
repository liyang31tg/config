-- 确保这是一个 Go 文件
if vim.bo.filetype ~= "javascript" then
    print("not js file")
    return
end

-- 防止重复加载
if vim.b.did_ftplugin_js then
    return
end
vim.b.did_ftplugin_js = true

print("js file loaded")

-- 设置本地 leader 键
vim.g.maplocalleader = "."

-- 运行当前文件
vim.api.nvim_buf_set_keymap(0, "n", "<LocalLeader>r", ":!ls", { noremap = true, silent = true })
