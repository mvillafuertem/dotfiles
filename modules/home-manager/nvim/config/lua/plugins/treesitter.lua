return {
	{

		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "lua", "vim", "rust", "toml", "bash" },
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{ "nvim-treesitter/playground" },
}
