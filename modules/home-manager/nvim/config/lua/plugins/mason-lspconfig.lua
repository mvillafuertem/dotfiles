return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				-- automatic_installation = true,
				ensure_installed = { "lua_ls", "rust_analyzer" },
			})
			-- require("lspconfig").ast_grep.setup({})
			-- require("lspconfig").nil_ls.setup({})
			-- require("lspconfig").lua_ls.setup({})
			-- require("lspconfig").rust_analyzer.setup({})
			--   on_attach = require("lspconfig").on_attach,
			--   capabilities = require("lspconfig").capabilities,
			--   filetypes = { "rust" },
			--   root_dir = require("lspconfig/util").root_pattern("Cargo.toml"),
			--   settings = {
			--     ["rust-analizer"] = {
			--       cargo = {
			--         allFeatures = true,
			--       },
			--     },
			--   },
			-- })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({})
      -- lspconfig.rust_analyzer.setup({})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
