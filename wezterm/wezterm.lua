local wezterm = require("wezterm")
local act = wezterm.action
local smart_splits = wezterm.plugin.require('https://github.com/mrjones2014/smart-splits.nvim')
local config = wezterm.config_builder()

if wezterm.config_builder then
  config = wezterm.config_builder()
end


config.color_scheme = "tokyonight_storm"
config.window_decorations = "RESIZE"
config.tab_bar_at_bottom = true
config.window_padding = {
  left = 2,
  right = 0,
  top = 0,
  bottom = 6,
}

config.font = wezterm.font({ family = "VictorMono Nerd Font", weight = "DemiBold" })
config.debug_key_events = false

config.keys = {
  {
    key = "d",
    mods = "SUPER",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "D",
    mods = "SUPER",
    action = wezterm.action.SplitPane {
      direction = 'Down',
      size = { Percent = 30 },
    },
  },
  { key = '1', mods = 'CMD', action = act.ActivatePaneByIndex(0) },
  { key = '2', mods = 'CMD', action = act.ActivatePaneByIndex(1) },
  { key = '3', mods = 'CMD', action = act.ActivatePaneByIndex(2) },
  { key = '4', mods = 'CMD', action = act.ActivatePaneByIndex(3) },
  {
    key = 'j',
    mods = 'SUPER',
    action = wezterm.action.TogglePaneZoomState,
  },

  -- { key = "s", mods = "CTRL", action = act.PaneSelect },
}
config.font_rules = {
  {
    intensity = "Bold",
    italic = true,
    font = wezterm.font({
      family = "SauceCodePro Nerd Font",
      weight = "Bold",
      style = "Italic",
    }),
  },
  {
    italic = true,
    intensity = "Half",
    font = wezterm.font({
      family = "SauceCodePro Nerd Font",
      weight = "DemiBold",
      style = "Italic",
    }),
  },
  {
    italic = true,
    intensity = "Normal",
    font = wezterm.font({
      family = "SauceCodePro Nerd Font",
      style = "Italic",
    }),
  },
}

config.window_background_opacity = 0.7
config.text_background_opacity = 0.7
smart_splits.apply_to_config(config, {
  direction_keys = { 'LeftArrow', 'DownArrow', 'UpArrow', 'RightArrow' },
  modifiers = {
    move = '',
    resize = 'ALT',
  },
})

return config
