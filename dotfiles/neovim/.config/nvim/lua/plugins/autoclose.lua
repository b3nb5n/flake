return {
	"autoclose-nvim",
	enabled = false,
	event = "InsertEnter",
	after = function()
		require("autoclose").setup({
			options = {
				pair_spaces = true,
				disable_command_mode = true,
			},
		})
	end,
}
