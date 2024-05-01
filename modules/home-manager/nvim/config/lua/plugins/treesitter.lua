return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				-- ensure_installed = { "c", "vim", "vimdoc", "lua", "rust", "toml", "bash" },
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	}
}
