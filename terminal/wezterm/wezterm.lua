local wezterm = require('wezterm')

local config = {}

config.font = wezterm.font 'Hack Nerd Font Mono'
config.font_size = 12.0
config.color_scheme = 'Solarized (dark) (terminal.sexy)'

config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

config.window_padding = {
  left = 1,
  right = 1,
  top = 1,
  bottom = 1
}

config.window_background_opacity = 0.9
config.text_background_opacity = 1.0

if not string.match(wezterm.target_triple, "darwin") then
  config.keys = {
    { key = '1', mods = 'ALT', action = wezterm.action.ActivateTab(0) },
    { key = '2', mods = 'ALT', action = wezterm.action.ActivateTab(1) },
    { key = '3', mods = 'ALT', action = wezterm.action.ActivateTab(2) },
    { key = '4', mods = 'ALT', action = wezterm.action.ActivateTab(3) },
    { key = '5', mods = 'ALT', action = wezterm.action.ActivateTab(4) },
    { key = '6', mods = 'ALT', action = wezterm.action.ActivateTab(5) },
    { key = '7', mods = 'ALT', action = wezterm.action.ActivateTab(6) },
    { key = '8', mods = 'ALT', action = wezterm.action.ActivateTab(7) },
    { key = '9', mods = 'ALT', action = wezterm.action.ActivateTab(-1) },
  }
end

return config
