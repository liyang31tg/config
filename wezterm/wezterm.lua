local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'nord'
-- config.font = wezterm.font 'JetBrains Mono'
config.font_size = 18
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations= 'TITLE | RESIZE'
config.keys = {
  -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
  {
    key = 's',
    mods = 'CMD',
    action = wezterm.action.SendKey { key = '9', mods = 'META' },
  },
}


return config
