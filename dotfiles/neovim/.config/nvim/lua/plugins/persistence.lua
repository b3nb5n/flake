return {
	"persistence-nvim",
	event = "UIEnter",
	after = function()
		local persistence = require("persistence")

		persistence.setup({
			dir = vim.fn.stdpath("state") .. "/sessions/",
			branch = true,
		})


		local load_session = true
		for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_get_name(bufnr) ~= "" then
				load_session = false
				break
			end
		end

		if load_session then
			persistence.load()
		else
			persistence.stop()
		end
	end,
}
