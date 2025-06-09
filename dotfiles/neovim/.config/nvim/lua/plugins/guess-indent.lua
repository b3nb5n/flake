return {
	"guess-indent",
	event = "DeferredUIEnter",
	after = function()
		local guess_indent = require("guess-indent")

		guess_indent.setup({
			auto_cmd = false,
			override_editorconfig = true,
		})

		vim.api.nvim_create_autocmd("BufEnter", {
			callback = function(params)
				guess_indent.set_from_buffer(params.buf, true, true)
			end,
		})
	end,
}
