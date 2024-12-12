local wezterm = require 'wezterm'

local config = {}
local act = wezterm.action

config.color_scheme = 'Dark Ocean (terminal.sexy)'
config.font_size = 16
config.window_background_opacity = 0.99
config.text_background_opacity = 0.99
config.window_background_image_hsb = {
  brightness = 0.425,
  hue = 1.0,
  saturation = 1.0,
}
config.automatically_reload_config = false

config.keys = {}
for i = 1, 8 do
  table.insert({}, {
    key = tostring(i),
    mods = 'CTRL|ALT',
    action = act.ActivateTab(i - 1),
  })
end

config.treat_left_ctrlalt_as_altgr = true

return config
