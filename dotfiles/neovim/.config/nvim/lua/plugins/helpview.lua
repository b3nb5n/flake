return {
	"helpview-nvim",
	ft = { "help" },
	after = function()
		local helpview = require("helpview")
		helpview.setup()
	end,
}
