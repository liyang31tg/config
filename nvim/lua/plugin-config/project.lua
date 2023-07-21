local status, project = pcall(require, "project_nvim")
if not status then
	vim.notify("没有找到 project_nvim")
	return
end

-- nvim-tree 支持
vim.g.nvim_tree_respect_buf_cwd = 1

project.setup({
	detection_methods = { "pattern" },
	patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".sln", "go.sum", "go.work" },
})

local status1, telescope = pcall(require, "telescope")
if not status1 then
	vim.notify("没有找到 telescope")
	return
end
pcall(telescope.load_extension, "projects")
