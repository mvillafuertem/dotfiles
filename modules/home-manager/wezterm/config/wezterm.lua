local wezterm = require("wezterm")

return {
  automatically_reload_config = true,
  hide_tab_bar_if_only_one_tab = true,
  window_close_confirmation = "NeverPrompt",
  -- Removes the title bar, leaving only the tab bar. Keeps
  -- the ability to resize by dragging the window's edges.
  -- On macOS, 'RESIZE|INTEGRATED_BUTTONS' also looks nice if
  -- you want to keep the window controls visible and integrate
  -- them into the tab bar.
  window_decorations = "RESIZE",
  window_background_opacity = 1.0,
  macos_window_background_blur = 30,
  color_scheme = "Catppuccin Mocha",                            -- or Macchiato, Frappe, Latte
  font = wezterm.font("JetBrainsMono NF", { weight = "Bold" }), -- wezterm ls-fonts --list-system
  font_size = 15.0,
  window_frame = {
    -- Berkeley Mono for me again, though an idea could be to try a
    -- serif font here instead of monospace for a nicer look?
    font = wezterm.font({ family = 'JetBrainsMono NF', weight = 'Bold' }),
    font_size = 15,
  },
  colors = {
    indexed = {
      [16] = "#000000",
    }
  },
  -- https://github.com/wez/wezterm/issues/3866
  send_composed_key_when_left_alt_is_pressed = true,
  keys = {
    -- we have to disable this key binding because we are using them in tmux
    -- https://wezfurlong.org/wezterm/config/default-keys.html
    {
      key = 'Tab',
      mods = 'CTRL',
      action = wezterm.action.DisableDefaultAssignment,
    },
    {
      key = 'Tab',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.DisableDefaultAssignment,
    },
    -- https://github.com/wez/wezterm/issues/1919
    {
      key = '-',
      mods = 'CTRL',
      action = wezterm.action.DisableDefaultAssignment
    },
    {
      key = '=',
      mods = 'CTRL',
      action = wezterm.action.DisableDefaultAssignment
    },
    {
      key = '_',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.DisableDefaultAssignment
    },
    {
      key = '+',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.DisableDefaultAssignment
    },
    -- https://tangledhelix.com/posts/iterm2-keymaps-for-tmux/
    -- In other macOS applications this key is used to move between windows,
    -- Let's replicate the behaviour but for tmux prefix + p(previous window) or prefix + n(next window).
    {
      key = 'LeftArrow',
      mods = 'OPT|CMD',
      action = wezterm.action.Multiple {
        wezterm.action.SendKey { key = 's', mods = "CTRL" },
        wezterm.action.SendKey { key = 'p' },
      }
    },
    {
      key = 'RightArrow',
      mods = 'OPT|CMD',
      action = wezterm.action.Multiple {
        wezterm.action.SendKey { key = 's', mods = "CTRL" },
        wezterm.action.SendKey { key = 'n' },
      }
    },
    --
    {
      key = '+',
      mods = 'CMD',
      action = wezterm.action.IncreaseFontSize
    },
  },
  mouse_bindings = {
    -- CMD-click will open the link under the mouse cursor
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'SHIFT',
      action = wezterm.action.DisableDefaultAssignment,
    },
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CMD',
      action = wezterm.action.OpenLinkAtMouseCursor,
    },
  }
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
