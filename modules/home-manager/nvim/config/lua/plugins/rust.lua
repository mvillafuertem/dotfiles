return {
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = "rust",
    dependencies = { "neovim/nvim-lspconfig", "j-hui/fidget.nvim" },
    config = function()
      require("fidget").setup({
        -- Options related to LSP progress subsystem
        progress = {
          ignore_done_already = true, -- Ignore new tasks that are already complete

          -- Options related to how LSP progress messages are displayed as notifications
          display = {
            render_limit = 3, -- How many LSP messages to show at once
          },
        },
        notification = {
          override_vim_notify = false,
        },
      })
      local lsp = require("lspconfig").rust_analyzer
      vim.g.rustaceanvim = {
        server = {
          -- on_attach = lsp.on_attach,
          on_attach = function(client, bufnr)
            lsp.on_attach(client, bufnr)
            lsp.on_dap_attach(bufnr)
          end,
          capabilities = lsp.capabilities,
          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
            },
          },
        },
      }
    end,
  },
  {
    "saecki/crates.nvim",
    dependencies = "hrsh7th/nvim-cmp",
    ft = { "rust", "toml" },
    config = function(_, opts)
      require("crates").setup(opts)
    end,
  },
}
