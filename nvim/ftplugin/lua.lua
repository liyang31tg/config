-- vim.keymap.set("n", "<leader>r", ":terminal lua %<CR>", {
-- 	buffer = 0,
-- 	noremap = true,
-- 	silent = true,
-- })
vim.keymap.set("n", "<leader>r", "<cmd>terminal lua %:p<CR>", { buffer = 0, noremap = true, silent = true })
