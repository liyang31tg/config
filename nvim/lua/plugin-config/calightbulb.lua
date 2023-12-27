local status, blub = pcall(require, "nvim-lightbulb")
if not status then
	vim.notify("没有找到 nvim-lightbulb")
	return
end



blub.setup({
  autocmd = { enabled = true }
})
