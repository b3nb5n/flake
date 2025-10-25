return {
	"nvim-surround",
	event = "DeferredUIEnter",
	after = function()
		local surround = require("nvim-surround")
		surround.setup({})
	end,
}
