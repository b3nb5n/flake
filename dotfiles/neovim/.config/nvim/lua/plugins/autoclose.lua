return {
	"autoclose-nvim",
	enabled = false,
	event = "InsertEnter",
	after = function()
		local autoclose = require("autoclose")

		autoclose.setup({
			options = {
				pair_spaces = true,
				disable_command_mode = true,
			},
		})
	end,
}
