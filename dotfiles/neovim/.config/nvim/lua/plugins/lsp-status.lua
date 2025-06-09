return {
	"lsp-status-nvim",
	event = "UIEnter",
	after = function()
		local lsp_status = require("lsp-status")

		lsp_status.register_progress()

		lsp_status.config({
			current_function = false,
			show_filename = false,
			diagnostics = false,
			kind_labels = {},
			status_symbol = "",
		})

		vim.lsp.config("*", {
			capabilities = lsp_status.capabilities,
			on_attach = lsp_status.on_attach,
		})
	end,
}
