return {
	"blink-cmp",
	event = "InsertEnter",
	after = function()
		local blink = require("blink-cmp")

		blink.setup({
			completion = {
				list = {
					selection = {
						preselect = false,
						auto_insert = false,
					},
				},
				menu = {
					draw = { treesitter = { "lsp" } },
				},
				ghost_text = {
					enabled = true,
				},
				documentation = {
					auto_show = true,
				},
				accept = {
					auto_brackets = { enabled = false },
				},
			},
			signature = {
				enabled = true,
			},
			keymap = {
				preset = "none",
				["<c-space>"] = { "show", "fallback" },
				["<down>"] = { "select_next", "fallback" },
				["<c-j>"] = { "select_next", "fallback" },
				["<up>"] = { "select_prev", "fallback" },
				["<c-k>"] = { "select_prev", "fallback" },
				["<enter>"] = { "accept", "fallback" },
			},
		})
	end,
}
