local opt = {
  options = {
    -- theme = "tokyonight",
    -- theme = "nord",
    component_separators = { left = "|", right = "|" },
    -- https://github.com/ryanoasis/powerline-extra-symbols
    --section_separators = { left = " ", right = "" },
    section_separators = { left = '', right = '' },
  },
  extensions = { "nvim-tree", "toggleterm" },
  sections = {
    lualine_c = {
      "filename",
      {
        "lsp_progress",
        spinner_symbols = { " ", " ", " ", " ", " ", " " },
      },
    },
    lualine_x = {
      "filesize",
      {
        "fileformat",
        -- symbols = {
        --   unix = '', -- e712
        --   dos = '', -- e70f
        --   mac = '', -- e711
        -- },
        symbols = {
          unix = "LF",
          dos = "CRLF",
          mac = "CR",
        },
      },
      "encoding",
      "filetype",
    },
  },
}
local obj = {
  'nvim-lualine/lualine.nvim',
  --config = function()
  -- require("lualine").setup(opt)
  --end,
  opts = opt,
  dependencies = { 'nvim-tree/nvim-web-devicons' }
}

return obj
