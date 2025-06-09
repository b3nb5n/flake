return {
	"typescript-tools-nvim",
	ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	after = function()
		local ts_tools = require("typescript-tools")

		ts_tools.setup({
			publish_diagnostic_on = "change",
			expose_as_code_action = "all",
			complete_function_calls = true,
		})
	end,
}
