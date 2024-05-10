return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	opts = {
		window = {
			auto_expand_width = true,
		},
		filesystem = {
			filtered_items = {
				hide_dotfiles = false,
			},
			group_empty_dirs = true,
		},
	},
	config = function(_, opts)
		vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})
		require("neo-tree").setup(opts)
	end,
}
