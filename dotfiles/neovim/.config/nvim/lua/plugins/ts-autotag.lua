return {
	"nvim-ts-autotag",
	event = "InsertEnter",
	after = function()
		local autotag = require("nvim-ts-autotag")

		autotag.setup({
			opts = {
				enable_close_on_slash = true,
			},
		})
	end,
}
