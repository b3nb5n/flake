return {
	"persistence-nvim",
	event = "UIEnter",
	after = function()
		local persistence = require("persistence")

		vim.opt.sessionoptions = { "buffers", "curdir", "options", "help" }

		persistence.setup()
		persistence.load()
	end,
}
