return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			dim_inactive = {
				enabled = true, -- dims the background color of inactive window
				shade = "light",
				percentage = 0.50, -- percentage of the shade to apply to the inactive window
			},
			integrations = {
				which_key = true,
			},
			custom_highlights = function(colors)
				return {
					WinSeparator = { fg = colors.blue },
				}
			end,
		})
		vim.cmd.colorscheme("catppuccin-nvim")
	end,
}
