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
          "helm_ls",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "j-hui/fidget.nvim",
      "nvim-treesitter/nvim-treesitter"
    },
    config = function()
      local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
      parser_config.gotmpl = {
        install_info = {
          url = "https://github.com/ngalaiko/tree-sitter-go-template",
          files = { "src/parser.c" }
        },
        filetype = "gotmpl",
        used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl", "yaml" }
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      local lspconfig = require("lspconfig")
      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
      lspconfig.ansiblels.setup({})
      -- lspconfig.azure_pipelines_ls.setup({
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
      -- https://github.com/Allaman/nvim/blob/main/lua/core/plugins/lsp/settings/yaml.lua
      lspconfig.yamlls.setup({
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
              ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] =
              "azure-pipelines.{yml,yaml}",
              ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/tasks"] =
              "roles/tasks/*.{yml,yaml}",
              ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/playbook"] =
              "*play*.{yml,yaml}",
              ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
              ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
              ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
              ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
              ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] =
              "*gitlab-ci*.{yml,yaml}",
              ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] =
              "*api*.{yml,yaml}",
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] =
              "*docker-compose*.{yml,yaml}",
              ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] =
              "*flow*.{yml,yaml}",
            },
            -- anabling this conflicts between Kubernetes resources and kustomization.yaml and Helmreleases
            -- see utils.custom_lsp_attach() for the workaround
            -- how can I detect Kubernetes ONLY yaml files? (no CRDs, Helmreleases, etc.)
            validate = false,
            completion = true,
            hover = true,
          }
        }
      })
      lspconfig.helm_ls.setup({})
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
