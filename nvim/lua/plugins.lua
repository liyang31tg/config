local packer = require("packer")
packer.startup({
  function(use)
    -- Packer 可以管理自己本身
    use 'wbthomason/packer.nvim'
    --主题
    use("folke/tokyonight.nvim")
    --侧栏目录结构
    use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })

    use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" }})
    --lualine
    use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
    use("arkav/lualine-lsp-progress")
    -- telescope （新增）
    use { 'nvim-telescope/telescope.nvim', requires = { "nvim-lua/plenary.nvim" } }

    -- dashboard-nvim (欢迎页面)
    use("glepnir/dashboard-nvim")
    -- project
    use("ahmedkhalf/project.nvim")

    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

     --------------------- LSP --------------------
    use("williamboman/nvim-lsp-installer")
    -- Lspconfig
    use({ "neovim/nvim-lspconfig" })
  end,
  config = {
    -- 并发数限制
    max_jobs = 16,
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "single" })
        end,
    },
    -- 自定义源
    git = {
      -- default_url_format = "https://hub.fastgit.xyz/%s",
      -- default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
      -- default_url_format = "https://gitcode.net/mirrors/%s",
      -- default_url_format = "https://gitclone.com/github.com/%s",
    },
  },
})

