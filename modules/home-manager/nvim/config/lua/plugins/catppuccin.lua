return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			integrations = {
				which_key = true,
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
