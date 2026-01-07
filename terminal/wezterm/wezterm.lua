local wezterm = require('wezterm')

wezterm.on('gui-attached', function(domain)
  local workspace = wezterm.mux.get_active_workspace()
  for _, window in ipairs(wezterm.mux.all_windows()) do
    if window:get_workspace() == workspace then
      window:gui_window():maximize()
    end
  end
end)

local config = {}

if string.match(wezterm.target_triple, "windows") then
  -- config.default_prog = { "wsl.exe", "--cd", "~" }
  config.default_prog = { 'pwsh.exe', '-NoLogo' }
end

config.font_size = 12.0
config.color_scheme = 'rose-pine-moon'

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
config.text_background_opacity = 0.9

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
    { key="Enter", mods="SHIFT", action=wezterm.action{SendString="\x1b\r"} },
  }

end

return config
