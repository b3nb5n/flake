return {
	"ccc-nvim",
	event = "DeferredUIEnter",
	after = function()
		local ccc = require("ccc")
		local style = require("tokyonight.config").options.style
		local colors = require("tokyonight.colors").styles[style]

		ccc.setup({
			highlighter = {
				auto_enable = true,
			},

			point_char = "•",
			point_on_color_dark = colors.fg,
			point_on_color_light = colors.bg,
			bar_len = 32,

			disable_default_mappings = true,
			mappings = {
				["<cr>"] = ccc.mapping.complete,
				["<esc>"] = ccc.mapping.quit,
				["<c-esc>"] = ccc.mapping.quit,
				["l"] = ccc.mapping.increase1,
				["L"] = ccc.mapping.increase10,
				["h"] = ccc.mapping.decrease1,
				["H"] = ccc.mapping.decrease10,
				["k"] = ccc.mapping.goto_prev,
				["j"] = ccc.mapping.goto_next,
				["a"] = ccc.mapping.toggle_alpha,
				["i"] = ccc.mapping.cycle_input_mode,
				["o"] = ccc.mapping.cycle_output_mode,
				["c"] = ccc.mapping.toggle_prev_colors,
				["<LeftMouse>"] = ccc.mapping.click,
				["<ScrollWheelDown>"] = ccc.mapping.decrease1,
				["<ScrollWheelUp>"] = ccc.mapping.increase1,
			},
		})

		vim.keymap.set("n", "<leader>oc", function()
			vim.cmd("CccPick")
		end)

		vim.keymap.set("n", "<leader>tc", function()
			vim.cmd("CccHighlighterToggle")
		end)
	end,
}
