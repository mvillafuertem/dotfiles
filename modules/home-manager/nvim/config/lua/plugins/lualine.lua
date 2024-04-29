return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "catppuccin",
			},
			tabline = {
				lualine_a = {
					{
						"buffers",
						mode = 4,
						icons_enabled = true,
						show_filename_only = true,
						hide_filename_extensions = false,
					},
				},
				lualine_z = {
					{ "tabs", max_length = vim.o.columns },
				},
			},
			winbar = {},
		})
	end,
}
