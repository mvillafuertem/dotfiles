return {
	"lewis6991/gitsigns.nvim",
	--  event = "User FilePost",
	--  opts = {
	--    signs = {
	--      add = { text = "│" },
	--      change = { text = "│" },
	--      delete = { text = "󰍵" },
	--      topdelete = { text = "‾" },
	--      changedelete = { text = "~" },
	--      untracked = { text = "│" },
	--    },
	--
	--    on_attach = function(bufnr)
	--      local gs = package.loaded.gitsigns
	--
	--      local function opts(desc)
	--        return { buffer = bufnr, desc = desc }
	--      end
	--
	--      local map = vim.keymap.set
	--
	--      map("n", "<leader>rh", gs.reset_hunk, opts("Reset Hunk"))
	--      map("n", "<leader>ph", gs.preview_hunk, opts("Preview Hunk"))
	--      map("n", "<leader>gb", gs.blame_line, opts("Blame Line"))
	--    end,
	--  },
	  config = function(_, opts)
	--    dofile(vim.g.base46_cache .. "git")
	    require("gitsigns").setup(opts)
      vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
      vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", {})
	  end,
}
