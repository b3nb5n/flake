return {
	"lualine-nvim",
	event = "UIEnter",
	before = function()
		local lzn = require("lz.n")
		lzn.trigger_load("tokyonight-nvim")
		lzn.trigger_load("lsp-status-nvim")
	end,
	after = function()
		local lualine = require("lualine")

		local theme = require("lualine.themes.tokyonight")
		vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
		theme.normal.c.bg = nil

		local section_caps = {
			left = "",
			right = "",
		}

		local function lsp_status()
			return require("lsp-status").status()
		end

		local function macro_status()
			local reg = vim.fn.reg_recording()
			if reg == "" then
				return ""
			end

			return "@" .. reg
		end

		lualine.setup({
			options = {
				theme = theme,
				globalstatus = true,
				component_separators = "",
				section_separators = {
					left = section_caps.right,
					right = section_caps.left,
				},
			},
			sections = {
				lualine_a = {
					{ "mode", separator = section_caps },
				},

				lualine_b = { { "branch", icon = "" }, "diff" },
				lualine_c = { "filename", macro_status },

				lualine_x = { lsp_status, "diagnostics" },
				lualine_y = { "filetype", "encoding", "fileformat" },

				lualine_z = {
					"selectioncount",
					{ "location", separator = section_caps },
				},
			},
		})
	end,
}
