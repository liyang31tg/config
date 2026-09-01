vim.api.nvim_create_user_command("Todo", function()
	vim.cmd("TodoTelescope keywords=TODO")
end, { desc = "todo list" })

vim.api.nvim_create_user_command("Fix", function()
	vim.cmd("TodoTelescope keywords=FIX,FIXME")
end, { desc = "todo list" })
