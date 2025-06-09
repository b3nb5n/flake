return {
	"hex-nvim",
	event = "DeferredUIEnter",
	after = function()
		local hex = require("hex")
		hex.setup()
	end,
}
