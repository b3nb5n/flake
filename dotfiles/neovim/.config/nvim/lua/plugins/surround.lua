return {
	"nvim-surround",
	event = "InsertEnter",
	after = function()
		local surround = require("nvim-surround")
		surround.setup({})
	end,
}
