return {
	"csv-view-nvim",
	ft = { "csv" },
	after = function()
		local csv = require("csvview")

		csv.setup({
			view = {
				display_mode = "border",
				sticky_header = {
					enabled = true,
					separator = "─",
				},
			},
			keymaps = {
				textobject_field_inner = { "ic", mode = { "o", "x" } },
				textobject_field_outer = { "ac", mode = { "o", "x" } },

				jump_prev_field_end = { "<c-h>", mode = "n" },
				jump_next_field_end = { "<c-l>", mode = "n" },
				jump_prev_row = { "<c-k>", mode = "n" },
				jump_next_row = { "<c-j", mode = "n" },
			},
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "csv",
			callback = function(params)
				csv.enable(params.buf)
			end,
		})
	end,
}
