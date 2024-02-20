local opt = {
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3,              -- spacing between columns
        align = "center",         -- align columns left, center or right
    },
    -- ignore_missing = true,                                                     -- enable this to hide mappings for which you didn't specify a label
}
local obj = {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    config = function()
        local mappings = require("keybindings").whichkeys
        local which_key = require("which-key")
        local opts = {
            mode = "n", -- NORMAL mode
            prefix = "<leader>",
            buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true, -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = true, -- use `nowait` when creating keymaps
        }
        which_key.setup(opt)
        which_key.register(mappings, opts)
    end,
}

return obj
