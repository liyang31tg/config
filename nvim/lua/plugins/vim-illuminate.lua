--高亮sameid
local opt = {
  -- providers: provider used to get references in the buffer, ordered by priority
  providers = {
    'lsp',
    -- 'treesitter',
    -- 'regex',
  },
  delay = 100,
}

local obj = {
  "RRethy/vim-illuminate",
  config= function()
    require("illuminate").configure(opt)
  end,
}

return obj
