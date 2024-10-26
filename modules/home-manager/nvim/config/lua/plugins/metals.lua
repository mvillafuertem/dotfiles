return {
  {
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "j-hui/fidget.nvim",
      "mfussenegger/nvim-dap",
    },
    ft = { "scala", "sbt", "java" },
    opts = function()
      local metals_config = require("metals").bare_config()

      -- Example of settings
      metals_config.settings = {
        -- excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
        showImplicitArguments = true,
        showImplicitConversionsAndClasses = true,
        showInferredType = true,
        superMethodLensesEnabled = true,
        useGlobalExecutable = true,
        inlayHints = {
          hintsInPatternMatch = { enable = true },
          implicitArguments = { enable = true },
          implicitConversions = { enable = true },
          inferredTypes = { enable = true },
          typeParameters = { enable = true },
        },
      }

      -- *READ THIS*
      -- I *highly* recommend setting statusBarProvider to either "off" or "on"
      --
      -- "off" will enable LSP progress notifications by Metals and you'll need
      -- to ensure you have a plugin like fidget.nvim installed to handle them.
      --
      -- "on" will enable the custom Metals status extension and you *have* to have
      -- a have settings to capture this in your statusline or else you'll not see
      -- any messages from metals. There is more info in the help docs about this
      metals_config.init_options.statusBarProvider = "off"

      -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
      metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

      metals_config.on_attach = function(client, bufnr)
        require("metals").setup_dap()
        -- Define your mappings with descriptions
        local keymaps = {
          {
            "n",
            "<leader>cW",
            function()
              require("metals").hover_worksheet()
            end,
            "Metals Worksheet",
          },
          {
            "n",
            "<leader>cM",
            function()
              require("telescope").extensions.metals.commands()
            end,
            "Telescope Metals Commands",
          },
          -- LSP mappings
          { "n", "gD",         vim.lsp.buf.declaration,     "Go to declaration" },
          { "n", "gd",         vim.lsp.buf.definition,      "Go to definition" },
          { "n", "K",          vim.lsp.buf.hover,           "Hover info" },
          { "n", "gi",         vim.lsp.buf.implementation,  "Go to implementation" },
          { "n", "gr",         vim.lsp.buf.references,      "Show references" },
          { "n", "<leader>D",  vim.lsp.buf.type_definition, "Type definition" },
          { "n", "<leader>cl", vim.lsp.codelens.run,        "Run CodeLens" },
          { "n", "<leader>sh", vim.lsp.buf.signature_help,  "Signature help" },
          { "n", "<leader>rn", vim.lsp.buf.rename,          "Rename symbol" },
          { "n", "<leader>f",  vim.lsp.buf.format,          "Format code" },
          { "n", "<leader>ca", vim.lsp.buf.code_action,     "Code action" },
          -- { "n", "<leader>gds", vim.lsp.buf.document_symbol,                       "Doc symbols" },
          {
            "n",
            "<leader>gds",
            function()
              require("telescope.builtin").lsp_document_symbols()
            end,
            "Doc symbols",
          },
          -- { "n", "gws",         vim.lsp.buf.workspace_symbol,                      "Workspace symbols" },
          {
            "n",
            "<leader>gws",
            function()
              require("telescope.builtin").lsp_dynamic_workspace_symbols()
            end,
            "Workspace symbols",
          },
          {
            "n",
            "<leader><leader>tr",
            function()
              require("metals.tvp").toggle_tree_view()
            end,
            "Tree View Protocol",
          },
          {
            "n",
            "<leader><leader>rt",
            function()
              require("metals.tvp").reveal_in_tree()
            end,
            "Reveal In Tree",
          },

          -- Diagnostic mappings
          { "n", "<leader>aa", vim.diagnostic.setqflist,  "All diagnostics" },
          {
            "n",
            "<leader>ae",
            function()
              vim.diagnostic.setqflist({ severity = "E" })
            end,
            "All errors",
          },
          {
            "n",
            "<leader>aw",
            function()
              vim.diagnostic.setqflist({ severity = "W" })
            end,
            "All warnings",
          },
          { "n", "<leader>d",  vim.diagnostic.setloclist, "Buffer diagnostics" },
          {
            "n",
            "[c",
            function()
              vim.diagnostic.goto_prev({ wrap = false })
            end,
            "Prev diagnostic",
          },
          {
            "n",
            "]c",
            function()
              vim.diagnostic.goto_next({ wrap = false })
            end,
            "Next diagnostic",
          },

          -- DAP (Debug Adapter Protocol) mappings
          {
            "n",
            "<leader>dc",
            function()
              require("dap").continue()
            end,
            "DAP continue",
          },
          {
            "n",
            "<leader>dr",
            function()
              require("dap").repl.toggle()
            end,
            "DAP REPL",
          },
          {
            "n",
            "<leader>dK",
            function()
              require("dap.ui.widgets").hover()
            end,
            "DAP hover",
          },
          {
            "n",
            "<leader>dt",
            function()
              require("dap").toggle_breakpoint()
            end,
            "Toggle breakpoint",
          },
          {
            "n",
            "<leader>dso",
            function()
              require("dap").step_over()
            end,
            "Step over",
          },
          {
            "n",
            "<leader>dsi",
            function()
              require("dap").step_into()
            end,
            "Step into",
          },
          {
            "n",
            "<leader>dl",
            function()
              require("dap").run_last()
            end,
            "Run last",
          },
        }

        -- Apply mappings in a loop
        for _, keymap in ipairs(keymaps) do
          local mode, lhs, rhs, desc = unpack(keymap)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end
      end

      return metals_config
    end,
    config = function(self, metals_config)
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = self.ft,
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end,
  },
}
