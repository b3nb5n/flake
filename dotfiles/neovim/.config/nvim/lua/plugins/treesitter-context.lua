return {
	"nvim-treesitter-context",
	enabled = false,
	event = "DeferredUIEnter",
	after = function()
		local ts_context = require("treesitter-context")

		ts_context.setup({
			multiline_threshold = 8,
			separator = "─",
		})

		vim.api.nvim_set_hl(0, "TreesitterContextSeparator", { bg = "none" })
	end,
}
