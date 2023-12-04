local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'nord'
-- config.font = wezterm.font 'JetBrains Mono'
config.font_size = 18
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations= 'TITLE | RESIZE'


return config
