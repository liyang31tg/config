local opt = {
    defaults = {
        -- 打开弹窗后进入的初始模式，默认为 insert，也可以是 normal
        initial_mode = "insert",
        -- 窗口内快捷键
        mappings = {
            i = {
                -- 上下移动
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
                ["<Down>"] = "move_selection_next",
                ["<Up>"] = "move_selection_previous",
                -- 历史记录
                ["<C-n>"] = "cycle_history_next",
                ["<C-p>"] = "cycle_history_prev",
                -- 关闭窗口
                ["<C-c>"] = "close",
                -- 预览窗口上下滚动
                ["<C-u>"] = "preview_scrolling_up",
                ["<C-d>"] = "preview_scrolling_down",
            },
        },
        preview = {
            mime_hook = function(filepath, bufnr, opts)
                local is_image = function(filepath)
                    local image_extensions = { "png", "jpg" } -- Supported image formats
                    local split_path = vim.split(filepath:lower(), ".", { plain = true })
                    local extension = split_path[#split_path]
                    return vim.tbl_contains(image_extensions, extension)
                end
                if is_image(filepath) then
                    local term = vim.api.nvim_open_term(bufnr, {})
                    local function send_output(_, data, _)
                        for _, d in ipairs(data) do
                            vim.api.nvim_chan_send(term, d .. "\r\n")
                        end
                    end
                    vim.fn.jobstart({
                        "catimg",
                        filepath, -- Terminal image viewer command
                    }, { on_stdout = send_output, stdout_buffered = true, pty = true })
                else
                    require("telescope.previewers.utils").set_preview_message(
                        bufnr,
                        opts.winid,
                        "Binary cannot be previewed"
                    )
                end
            end,
        },
    },
    pickers = {
        -- 内置 pickers 配置
        find_files = {
            -- 查找文件换皮肤，支持的参数有： dropdown, cursor, ivy
            -- theme = "dropdown",
        },
    },
    extensions = {
        -- 扩展插件配置
    },
}
vim.g.nvim_tree_respect_buf_cwd = 1


local obj = {
    "nvim-telescope/telescope.nvim",
    opts = opt,
    dependencies = {
        'nvim-lua/plenary.nvim',
        "ahmedkhalf/project.nvim",
    },
    config = function(_, opts)
        local telescope = require("telescope")
        telescope.setup(opts)
        vim.g.nvim_tree_respect_buf_cwd = 1
        local opts_project = {
            detection_methods = { "pattern" },
            patterns = {
                ".git",
                "_darcs",
                ".hg",
                ".bzr",
                ".svn",
                "Makefile",
                "package.json",
                ".sln",
                "go.sum",
                "go.work",
                ".csproj",
                "Unity.Neovim.Editor.csproj",
            },
        }
        require("project_nvim").setup(opts_project)
        telescope.load_extension('projects')
    end
}
return obj
