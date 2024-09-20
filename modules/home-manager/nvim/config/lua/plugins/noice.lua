return {
	"folke/noice.nvim",
  enabled = false,
	event = "VeryLazy",
	keys = {
		{
			"<leader>nd",
			"<cmd>NoiceDismiss<cr>",
			desc = "Dismiss Noice Message",
		},
	},
	opts = {
		routes = {
			{
				filter = { event = "notify", find = "No information available" },
				opts = { skip = true },
			},
			--       {
			--        view = "notify",
			--        filter = { event = "msg_showmode" },
			--      },
		},
		presets = {
			lsp_doc_border = true,
		},
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = function(_, opts)
		vim.opt.showmode = false
	end,
}
