return {
	"nvim-dap-virtual-text",
	event = "DeferredUIEnter",
	before = function()
		local lzn = require("lz.n")
		lzn.trigger_load("nvim-dap")
	end,
	after = function()
		local dap_virtual_text = require("nvim-dap-virtual-text")

		dap_virtual_text.setup({
			all_frames = true,
			virt_text_pos = "eol",
		})
	end,
}
