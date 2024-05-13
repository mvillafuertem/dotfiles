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
					-- "azure_pipelines_ls",
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
					-- "helm_ls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = "j-hui/fidget.nvim",
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

			-- require("mason-lspconfig").setup_handlers({
			--   -- The first entry (without a key) will be the default handler
			--   -- and will be called for each installed server that doesn't have
			--   -- a dedicated handler.
			--   function(server_name) -- default handler (optional)
			--     require("lspconfig")[server_name].setup({
			--       capabilities = capabilities,
			--     })
			--   end,
			--   ["yamlls"] = function()
			--     require("lspconfig").yamlls.setup({
			--       capabilities = capabilities,
			--       settings = {
			--         yaml = {
			--           schemas = {
			--             kubernetes = "/*.yaml",
			--             -- Add the schema for gitlab piplines
			--             -- ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*.gitlab-ci.yml",
			--           },
			--         },
			--       },
			--     })
			--   end,
			-- })
			local lspconfig = require("lspconfig")
			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
			lspconfig.ansiblels.setup({})
			-- lspconfig.azure_pipelines_ls.setup({})
			lspconfig.bashls.setup({})
			lspconfig.cypher_ls.setup({})
			lspconfig.docker_compose_language_service.setup({})
			lspconfig.dockerls.setup({})
			lspconfig.lua_ls.setup({
				capabilities = lsp_capabilities,
			})
			lspconfig.nil_ls.setup({})
			lspconfig.terraformls.setup({})
			lspconfig.tsserver.setup({})
			lspconfig.yamlls.setup({})
			-- lspconfig.helm_ls.setup({})
			-- lspconfig.rust_analyzer.setup({})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

      -- https://github.com/Alexis12119/nvim-config/blob/main/lua/plugins/lsp/init.lua#L52C1-L58C7
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "rounded",
			})

			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = "rounded",
			})
		end,
	},
}
