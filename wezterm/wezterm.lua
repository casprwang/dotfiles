-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
local smart_splits = wezterm.plugin.require('https://github.com/mrjones2014/smart-splits.nvim')
local config = wezterm.config_builder()

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end


-- This is where you actually apply your config choices

-- For example, changing the color scheme:
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

-- timeout_milliseconds defaults to 1000 and can be omitted
-- config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
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
-- and finally, return the configuration to wezterm
smart_splits.apply_to_config(config, {
  -- the default config is here, if you'd like to use the default keys,
  -- you can omit this configuration table parameter and just use
  -- smart_splits.apply_to_config(config)

  -- directional keys to use in order of: left, down, up, right
  direction_keys = { 'LeftArrow', 'DownArrow', 'UpArrow', 'RightArrow' },
  -- modifier keys to combine with direction_keys
  modifiers = {
    move = '',      -- modifier to use for pane movement, e.g. CTRL+h to move left
    resize = 'ALT', -- modifier to use for pane resize, e.g. META+h to resize to the left
  },
})

return config
