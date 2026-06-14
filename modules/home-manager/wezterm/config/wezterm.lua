local wezterm = require("wezterm")
-- local tmux_startup = require 'tmux_startup'

return {
	audible_bell = "Disabled",
	-- default_prog = { "/etc/profiles/per-user/miguel.villafuerte/bin/bash", "-l", "-c", "tmux new-session -A -s main" },
	-- Menú de lanzamiento para servidores remotos
	-- launch_menu = remote_servers.create_launch_menu(),
	-- Pestaña local automática al iniciar
	-- wezterm.on("gui-startup", tmux_startup.create_local_tab), -- Menú de lanzamiento para servidores remotos
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
	color_scheme = "Catppuccin Mocha", -- or Macchiato, Frappe, Latte
	font = wezterm.font("JetBrainsMono NF", { weight = "Bold" }), -- wezterm ls-fonts --list-system
	font_size = 15.0,
	window_frame = {
		-- Berkeley Mono for me again, though an idea could be to try a
		-- serif font here instead of monospace for a nicer look?
		font = wezterm.font({ family = "JetBrainsMono NF", weight = "Bold" }),
		font_size = 15,
	},
	colors = {
		indexed = {
			[16] = "#000000",
		},
	},
	-- https://github.com/wez/wezterm/issues/3866
	send_composed_key_when_left_alt_is_pressed = true,
  send_composed_key_when_right_alt_is_pressed = false,
  -- https://github.com/wezterm/wezterm/discussions/6193
  -- use_dead_keys = false,
	keys = {
		-- we have to disable this key binding because we are using them in tmux
		-- https://wezfurlong.org/wezterm/config/default-keys.html
		-- wezterm show-keys --lua
		{
			key = "Tab",
			mods = "CTRL",
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			key = "Tab",
			mods = "CTRL|SHIFT",
			action = wezterm.action.DisableDefaultAssignment,
		},
		-- https://github.com/wez/wezterm/issues/1919
		{
			key = "-",
			mods = "CTRL",
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			key = "=",
			mods = "CTRL",
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			key = "_",
			mods = "CTRL|SHIFT",
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			key = "+",
			mods = "CTRL|SHIFT",
			action = wezterm.action.DisableDefaultAssignment,
		},
		-- https://tangledhelix.com/posts/iterm2-keymaps-for-tmux/
		-- In other macOS applications this key is used to move between windows,
		-- Let's replicate the behaviour but for tmux prefix + p(previous window) or prefix + n(next window).
		{
			key = "LeftArrow",
			mods = "OPT|CMD",
			action = wezterm.action.Multiple({
				wezterm.action.SendKey({ key = "s", mods = "CTRL" }),
				wezterm.action.SendKey({ key = "p" }),
			}),
		},
		{
			key = "RightArrow",
			mods = "OPT|CMD",
			action = wezterm.action.Multiple({
				wezterm.action.SendKey({ key = "s", mods = "CTRL" }),
				wezterm.action.SendKey({ key = "n" }),
			}),
		},
		{
			-- key = "LeftArrow",
			key = "h",
			mods = "OPT|CMD",
			action = wezterm.action.Multiple({
				wezterm.action.SendKey({ key = "s", mods = "CTRL" }),
				wezterm.action.SendKey({ key = "p" }),
			}),
		},
		{
			-- key = "RightArrow",
			key = "l",
			mods = "OPT|CMD",
			action = wezterm.action.Multiple({
				wezterm.action.SendKey({ key = "s", mods = "CTRL" }),
				wezterm.action.SendKey({ key = "n" }),
			}),
		},
		{
			key = "+",
			mods = "CMD",
			action = wezterm.action.IncreaseFontSize,
		},
		-- {
		-- 	key = "s",
		-- 	mods = "CMD|SHIFT",
		-- 	action = wezterm.action.ShowLauncherArgs({ flags = "LAUNCH_MENU_ITEMS" }),
		-- },
		-- https://alexplescan.com/posts/2024/08/10/wezterm/
		-- {
		-- 	key = "p",
		-- 	mods = "CMD",
		-- 	-- Present in to our project picker
		-- 	action = projects.choose_project(),
		-- },
		-- {
		-- 	key = "f",
		-- 	mods = "CMD",
		-- 	-- Present a list of existing workspaces
		-- 	action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
		-- },
	},
	mouse_bindings = {
		-- CMD-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "SHIFT",
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CMD",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
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
