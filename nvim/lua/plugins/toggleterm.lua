local opt = {
    size = 20,
    -- TODO: add my own keymapping to <space-t>
    open_mapping = [[<c-\>]],
    hide_numbers = false,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 3,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = "curved",
        winblend = 3,
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
}

local obj = {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = opt,
    config = function(_, opts)
        require("toggleterm").setup(opts)
        function _G.set_terminal_keymaps()
            local optss = { noremap = true }
            vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], optss)
            vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], optss)
            vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], optss)
            vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], optss)
            -- ctrl l preserved for clear terminal content
            -- vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
        end

        vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

        local Terminal = require("toggleterm.terminal").Terminal
        local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

        -- sudo add-apt-repository ppa:lazygit-team/release
        -- sudo apt-get update
        -- sudo apt-get install lazygit
        function _LAZYGIT_TOGGLE()
            lazygit:toggle()
        end

        local gitui = Terminal:new({ cmd = "gitui", hidden = true })

        function _GITUI_TOGGLE()
            gitui:toggle()
        end

        local node = Terminal:new({ cmd = "node", hidden = true })

        function _NODE_TOGGLE()
            node:toggle()
        end

        local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })

        function _NCDU_TOGGLE()
            ncdu:toggle()
        end

        local htop = Terminal:new({ cmd = "htop", hidden = true })

        function _HTOP_TOGGLE()
            htop:toggle()
        end

        local python = Terminal:new({ cmd = "python", hidden = true })

        function _PYTHON_TOGGLE()
            python:toggle()
        end
    end,
}

return obj
