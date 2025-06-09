return {
	"tokyonight-nvim",
	event = "UIEnter",
	after = function()
		local tokyonight = require("tokyonight")
		local config = require("tokyonight.config")
		local themes = require("tokyonight.colors")

		tokyonight.setup({
			style = "night",
			transparent = true,
			styles = {
				comments = { italic = false },
				keywords = { italic = false },
			},
		})

		vim.cmd.colorscheme("tokyonight")
		vim.o.winborder = "rounded"

		local colors = themes.styles[config.options.style]
		local winborder_hl = { fg = colors.fg }

		vim.api.nvim_set_hl(0, "FloatBorder", winborder_hl)
		vim.api.nvim_set_hl(0, "FzfLuaBorder", winborder_hl)
		vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", winborder_hl)
		vim.api.nvim_set_hl(0, "LspFloatWinBorder", winborder_hl)
		vim.api.nvim_set_hl(0, "LspInfoBorder", winborder_hl)
	end,
}
