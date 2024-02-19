local obj = {
  "glepnir/zephyr-nvim",
  config = function()
    vim.cmd [[ colorscheme zephyr ]]
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },

}

return obj
