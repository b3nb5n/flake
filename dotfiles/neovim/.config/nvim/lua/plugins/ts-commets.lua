return {
	"ts-comments-nvim",
	event = "InsertEnter",
	after = function()
		local comments = require("ts-comments")
		comments.setup({})
	end,
}
