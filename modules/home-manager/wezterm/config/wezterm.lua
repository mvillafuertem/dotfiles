local wezterm = require("wezterm")

return {
  automatically_reload_config = true,
  hide_tab_bar_if_only_one_tab = true,
  window_close_confirmation = "NeverPrompt",
  window_decorations = "RESIZE",
  color_scheme = "Catppuccin Mocha", -- or Macchiato, Frappe, Latte
  font = wezterm.font("JetBrainsMono NF", { weight = "Bold" }), -- wezterm ls-fonts --list-system
  font_size = 13.0,
  -- window_padding = {
  --   left = 3,
  --   right = 3,
  --   top = 0,
  --   bottom = 0
  -- },
  -- keys = {
  --   {
  --     key = ",",
  --     mods = "CMD",
  --     action = wezterm.action.SpawnCommandInNewWindow({
  --       cwd = os.getenv("WEZTERM_CONFIG_DIR"),
  --       args = { os.getenv("SHELL"), "-c", "$EDITOR $WEZTERM_CONFIG_FILE" },
  --     }),
  --   },
  --   {
  --     key = 'y',
  --     mods = 'CMD',
  --     action = wezterm.action.SpawnCommandInNewWindow {
  --       args = { 'sleep', '1', '&&', 'echo', 'hola' },
  --     },
  --   },
  -- }
}
