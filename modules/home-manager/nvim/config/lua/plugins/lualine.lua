return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- Define la función para procesar las secciones
		local function process_sections(sections)
			for _, section in pairs(sections) do
				for id, comp in ipairs(section) do
					if type(comp) ~= "table" then
						comp = { comp }
						section[id] = comp
					end
					comp.component_separators = { left = "", right = "" }
					comp.section_separators = { left = "", right = "" }
				end
			end
			return sections
		end

		require("lualine").setup({
			extensions = { "quickfix" },
			options = {
				theme = "catppuccin",
				globalstatus = true,
				component_separators = "",
				section_separators = { left = "", right = "" },
				-- component_separators = { left = "", right = "" },
				-- section_separators = { left = "", right = "" },
			},
			tabline = process_sections({
				lualine_a = {
					{
						"buffers",
						mode = 0,
						icons_enabled = true,
						show_filename_only = true,
						hide_filename_extensions = false,
						separator = { left = "", right = "" },
						right_padding = 2,
						symbols = {
							modified = " ●", -- Text to show when the buffer is modified
							alternate_file = "⧉ ", -- Text to show to identify the alternate file
							directory = " ", -- Text to show when the buffer is a directory
						},
					},
				},
				-- lualine_b = {
				--   {
				--     "",
				--     separator = { right = "" },
				--     right_padding = 2,
				--   },
				-- },
				lualine_z = {
					{
						"tabs",
						-- separator = { right = "" },
						max_length = vim.o.columns,
						cond = function()
							return #vim.fn.gettabinfo() > 1
						end,
					},
				},
			}),
			sections = {
				lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = {
					{
						require("lazy.status").updates,
						cond = require("lazy.status").has_updates,
						color = { fg = "#ff9e64" },
					},
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_y = { "progress", "%L" },
				lualine_z = {
					{ "location", separator = { right = "" }, right_padding = 2 },
				},
			},
			--			sections = {
			--				lualine_a = {
			--					"mode",
			--					{
			--						require("noice").api.statusline.mode.get,
			--						cond = require("noice").api.statusline.mode.has,
			--						-- color = { fg = "#ff9e64" },
			--					},
			--				},
			--			},
			inactive_winbar = {
				-- lualine_c = { "filename" },
				-- lualine_y = { { "filetype", icon_only = true } },
				-- lualine_z = { { "filename", path = 1 } },
			},
		})
	end,
}
