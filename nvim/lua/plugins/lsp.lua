local obj = {
  "neovim/nvim-lspconfig",
  dependencies={
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config=function()
    require("mason").setup()
  end
}

return obj
