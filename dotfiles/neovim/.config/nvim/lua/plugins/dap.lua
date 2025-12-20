return {
	"nvim-dap",
	event = "DeferredUIEnter",
	after = function()
		local dap = require("dap")

		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
		vim.keymap.set("n", "<leader>dq", dap.terminate)
		vim.keymap.set("n", "<leader>dr", dap.restart)
		vim.keymap.set("n", "<leader>dc", dap.continue)

		vim.keymap.set("n", "<leader>dh", dap.restart_frame)
		vim.keymap.set("n", "<leader>dl", dap.step_over)
		vim.keymap.set("n", "<leader>dj", dap.step_into)
		vim.keymap.set("n", "<leader>dk", dap.step_out)

		vim.fn.sign_define("DapBreakpoint", {
			text = "●",
			texthl = "Debug"
		})
	end
}
