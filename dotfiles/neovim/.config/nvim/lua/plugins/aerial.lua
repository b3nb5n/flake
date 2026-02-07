return {
	"aerial",
	event = "DeferredUIEnter",
	after = function()
		local aerial = require("aerial")

		aerial.setup({
			nav = {
				win_opts = {
					winblend = 0,
				},
			},
		})

		vim.keymap.set("n", "<leader>ls", aerial.nav_open)
		vim.keymap.set("n", "<leader>fs", aerial.fzf_lua_picker)
	end
}
