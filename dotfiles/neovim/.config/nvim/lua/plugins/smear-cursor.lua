return {
	"smear-cursor-nvim",
	enabled = function()
		if vim.env.SSH_CLIENT then
			return false
		end

		return true
	end,
	event = "DeferredUIEnter",
	after = function()
		local smear = require("smear_cursor")

		smear.setup({
			smear_between_buffers = false,
			scroll_buffer_space = false,
		})

		-- vim.keymap.set("n", "<leader>tc", function()
		-- 	smear.toggle()
		-- 	local enabled = smear.enabled and "enabled" or "disabled"
		-- 	vim.notify("Cursor smearing is now " .. enabled .. ".")
		-- end)
	end,
}
