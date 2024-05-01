return {

	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {

				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.nixfmt,
				null_ls.builtins.formatting.scalafmt,
				null_ls.builtins.formatting.buf,

				null_ls.builtins.diagnostics.buf,
				require("none-ls.formatting.jq"),
				-- require("none-ls.diagnostics.ast_grep"),
				-- require("none-ls.formatting.ast_grep"),
				-- null_ls.builtins.formatting.ast_grep,
				-- null_ls.diagnostics.ast_grep,
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
