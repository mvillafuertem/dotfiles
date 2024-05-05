return {
	"j-hui/fidget.nvim",
	opts = {
		-- Options related to LSP progress subsystem
		progress = {
			ignore_done_already = true, -- Ignore new tasks that are already complete

			-- Options related to how LSP progress messages are displayed as notifications
			display = {
				render_limit = 3, -- How many LSP messages to show at once
			},
		},
		notification = {
			override_vim_notify = false,
		},
		-- Options related to integrating with other plugins
		integration = {
			["nvim-tree"] = {
				enable = true, -- Integrate with nvim-tree/nvim-tree.lua (if installed)
			},
		},
	}, -- options
}
