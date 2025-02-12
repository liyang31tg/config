return {
    { --欢迎页面
        "goolord/alpha-nvim",
        config = function()
            require("alpha").setup(require("alpha.themes.theta").config)
        end,
    },
    { --顶部的buffer列表
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons", "https://github.com/moll/vim-bbye" },
        config = function()
            local opt = {
                options = {
                    -- 关闭 Tab 的命令，这里使用 moll/vim-bbye 的 :Bdelete 命令
                    close_command = "Bdelete! %d",
                    right_mouse_command = "Bdelete! %d",

                    diagnostics = "nvim_lsp",
                    diagnostics_indicator = function(count, level, diagnostics_dict, context)
                        local s = " "
                        for e, n in pairs(diagnostics_dict) do
                            local sym = e == "error" and " " or (e == "warning" and " " or "")
                            s = s .. n .. sym
                        end
                        return s
                    end,
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            text_align = "left",
                            separator = true,
                        },
                    },
                },
            }
            require("bufferline").setup(opt)
        end,
    },
    { --ui美化,特别是rename
        "stevearc/dressing.nvim",
        config = true,
    },
    { -- 缩进指示线
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            scope = {
                show_start = false,
                show_end = false,
            },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                -- theme = "tokyonight",
                -- theme = "nord",
                component_separators = { left = "|", right = "|" },
                -- https://github.com/ryanoasis/powerline-extra-symbols
                --section_separators = { left = " ", right = "" },
                section_separators = { left = "", right = "" },
            },
            extensions = { "nvim-tree", "toggleterm" },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = {
                    'filename',
                    {
                        "lsp_progress",
                        spinner_symbols = { " ", " ", " ", " ", " ", " " },
                    },
                },
                lualine_x = {
                    "filesize",
                    {
                        "fileformat",
                        symbols = {
                            dos = "", -- e70f
                            mac = "", -- e711
                            linux = '', -- Linux 图标
                            windows = '', -- Windows 图标
                            macos = '', -- MacOS 图标
                            unix = '', -- Unix 图标
                            android = '', -- Android 图标
                            ios = '', -- iOS 图标（与 MacOS 相同）
                        },
                    },
                    'encoding',
                    'filetype',
                    {
                        function()
                            return vim.fn.reg_recording() ~= '' and 'Recording @ ' .. vim.fn.reg_recording() or ''
                        end,
                        color = { fg = 'yellow' }
                    }
                },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            }
        },
        dependencies = { "nvim-tree/nvim-web-devicons", "arkav/lualine-lsp-progress" },
    },
    { --hilight sameid
        "RRethy/vim-illuminate",
        opts = {
            delay = 200,
            providers = {
                "lsp",
            },
            large_file_cutoff = 2000,
        },
        config = function(_, opts)
            require("illuminate").configure(opts)
        end,
    },
    {
        "hedyhli/outline.nvim",
        config = true,
    },
}
