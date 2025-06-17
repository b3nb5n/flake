return {
	"noice-nvim",
	event = "DeferredUIEnter",
	before = function()
		vim.cmd.packadd("nui-nvim")
		vim.cmd.packadd("nvim-notify")
	end,
	after = function()
		local noice = require("noice")

		noice.setup({
			lsp = {
				progress = { enabled = false },
				hover = { enabled = false },
				signature = { enabled = false },
			},
		})
	end,
}
