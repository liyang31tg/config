local status, c = pcall(require, "Comment")
if not status then
	vim.notify("没有找到 Comment")
	return
end

c.setup()
