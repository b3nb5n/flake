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
		local win_hl = { fg = colors.fg, bg = "NONE" }

		vim.api.nvim_set_hl(0, "NormalFloat", win_hl)
		vim.api.nvim_set_hl(0, "FloatBorder", win_hl)

		vim.api.nvim_set_hl(0, "Pmenu", win_hl)
		vim.api.nvim_set_hl(0, "PmenuExtra", win_hl)
		vim.api.nvim_set_hl(0, "PmenuKind", win_hl)

		vim.api.nvim_set_hl(0, "LspFloatWinBorder", win_hl)
		vim.api.nvim_set_hl(0, "LspInfoBorder", win_hl)

		vim.api.nvim_set_hl(0, "FzfLuaNormal", win_hl)
		vim.api.nvim_set_hl(0, "FzfLuaBorder", win_hl)
		vim.api.nvim_set_hl(0, "FzfLuaTitle", win_hl)
		vim.api.nvim_set_hl(0, "FzfLuaTitleFlags", win_hl)
		vim.api.nvim_set_hl(0, "FzfLuaPreviewTitle", win_hl)

		vim.api.nvim_set_hl(0, "BlinkCmpDoc", win_hl)
		vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", win_hl)
	end,
}
