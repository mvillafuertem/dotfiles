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
					-- "gopls",
					-- "azure_pipelines_ls",
					"bashls",
					"cypher_ls",
					"docker_compose_language_service",
					"dockerls",
					"lua_ls",
					"nil_ls",
					"rust_analyzer",
					"terraformls",
					"tflint",
					-- "tsserver",
					"yamlls",
					"helm_ls", --
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"j-hui/fidget.nvim",
			"nvim-treesitter/nvim-treesitter",
			"towolf/vim-helm",
		},
		config = function(_, opts)
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- Use an on_attach function to only map the following keys
			-- after the language server attaches to the current buffer
			local on_attach = function(client, bufnr)
				-- Enable completion triggered by <c-x><c-o>
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

				-- Mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions

				vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-S>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
				vim.api.nvim_buf_set_keymap(
					bufnr,
					"n",
					"<space>wa",
					"<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
					opts
				)
				vim.api.nvim_buf_set_keymap(
					bufnr,
					"n",
					"<space>wr",
					"<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
					opts
				)
				vim.api.nvim_buf_set_keymap(
					bufnr,
					"n",
					"<space>wl",
					"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
					opts
				)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
			end

			vim.lsp.config("ansiblels", {})
			-- vim.lsp.config("azure_pipelines_ls", {
			--   capabilities = lsp_capabilities,
			--   settings = {
			--     yaml = {
			--       schemas = {
			--         ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
			--           "**/azure-pipelines.yml",
			--           "**/azure-pipelines.yaml",
			--           "**/azure/**/*.yml",
			--           "**/azure/**/*.yaml",
			--         },
			--       },
			--     },
			--   },
			-- })
			vim.lsp.config("bashls", {})
			vim.lsp.config("cypher_ls", {})
			vim.lsp.config("docker_compose_language_service", {})
			vim.lsp.config("dockerls", {})
			vim.lsp.config("lua_ls", {
				on_attach = on_attach,
				capabilities = lsp_capabilities,
				filetypes = { "lua" },
			})
			vim.lsp.config("nil_ls", {})
			vim.lsp.config("terraformls", {
				on_attach = on_attach,
				capabilities = lsp_capabilities,
				filetypes = { "terraform", "tf", "terraform-vars" },
			})
			vim.lsp.config("tflint", {
				capabilities = lsp_capabilities,
				filetypes = { "terraform", "tf", "terraform-vars" },
			})
			-- vim.lsp.config("tsserver", {
			--  on_attach = on_attach,
			--  capabilities = lsp_capabilities,
			--  filetypes = { "typescript", "js" },
			-- })
			-- https://github.com/Allaman/nvim/blob/main/lua/core/plugins/lsp/settings/yaml.lua
			vim.lsp.config("yamlls", {
				on_attach = on_attach,
				capabilities = lsp_capabilities,
				filetypes = { "yaml", "yml" },
				settings = {
					yaml = {
						format = {
							enable = false,
						},
						schemaStore = {
							enable = true,
							url = "https://www.schemastore.org/api/json/catalog.json",
						},
						schemas = {
							kubernetes = "*.yaml",
							["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
							["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
							["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = "azure-pipelines.{yml,yaml}",
							["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/tasks"] = "roles/tasks/*.{yml,yaml}",
							["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/playbook"] = "*play*.{yml,yaml}",
							["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
							["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
							["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
							["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
							["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*gitlab-ci*.{yml,yaml}",
							["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
							["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
							["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
						},
						-- anabling this conflicts between Kubernetes resources and kustomization.yaml and Helmreleases
						-- see utils.custom_lsp_attach() for the workaround
						-- how can I detect Kubernetes ONLY yaml files? (no CRDs, Helmreleases, etc.)
						validate = false,
						completion = true,
						hover = true,
					},
				},
			})

			-- local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
			-- parser_config.gotmpl = {
			--   install_info = {
			--     url = "https://github.com/ngalaiko/tree-sitter-go-template",
			--     files = { "src/parser.c" }
			--   },
			--   filetype = "gotmpl",
			--   used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl" }
			-- }
			-- https://github.com/cksidharthan/nvim/blob/main/lua/sid/plugins/lsp/lspconfig.lua#L36C36-L47C4
			-- lspconfig.gopls.setup({
			--   capabilities = capabilities,
			--   settings = {
			--     gopls = {
			--       analyses = {
			--         unusedparams = true,
			--       },
			--       staticcheck = true,
			--     },
			--   },
			-- })
			vim.lsp.config("helm_ls", {
				on_attach = on_attach,
				capabilities = lsp_capabilities,
				settings = {
					["helm-ls"] = {
						yamlls = {
							path = "yaml-language-server",
						},
					},
				},
			})
			-- vim.lsp.config("rust_analyzer", {})
			-- https://github.com/Alexis12119/nvim-config/blob/main/lua/plugins/lsp/init.lua#L52C1-L58C7
			vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
				config = config or {}
				config.border = "rounded"
				vim.lsp.handlers.hover(err, result, ctx, config)
			end

			vim.lsp.handlers["textDocument/signatureHelp"] = function(err, result, ctx, config)
				config = config or {}
				config.border = "rounded"
				vim.lsp.handlers.signature_help(err, result, ctx, config)
			end
		end,
	},
}
