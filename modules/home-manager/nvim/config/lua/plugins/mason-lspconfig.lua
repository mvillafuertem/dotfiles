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
				ensure_installed = {
					"ansiblels",
					"azure_pipelines_ls",
					"bashls",
					"cypher_ls",
					"docker_compose_language_service",
					"dockerls",
					"lua_ls",
					"nil_ls",
					"rust_analyzer",
					"terraformls",
					"tsserver",
					"yamlls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = "j-hui/fidget.nvim",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({})
			lspconfig.ansiblels.setup({})
			lspconfig.azure_pipelines_ls.setup({})
			lspconfig.bashls.setup({})
			lspconfig.cypher_ls.setup({})
			lspconfig.docker_compose_language_service.setup({})
			lspconfig.dockerls.setup({})
			lspconfig.lua_ls.setup({})
			lspconfig.nil_ls.setup({})
			lspconfig.terraformls.setup({})
			lspconfig.tsserver.setup({})
			lspconfig.yamlls.setup({})
			-- lspconfig.rust_analyzer.setup({})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
