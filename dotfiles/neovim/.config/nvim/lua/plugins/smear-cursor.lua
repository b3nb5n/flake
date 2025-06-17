return {
	"smear-cursor-nvim",
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
