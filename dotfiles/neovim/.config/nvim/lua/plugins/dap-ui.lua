return {
	"nvim-dap-ui",
	event = "DeferredUIEnter",
	before = function ()
		vim.cmd.packadd("nvim-nio")

		local lzn = require("lz.n")
		lzn.trigger_load("nvim-dap")
	end,
	after =	function()
		local dapui = require("dapui")
		dapui.setup()

		local dap = require("dap")
		dap.listeners.before.attach.dapui_config = dapui.open
		dap.listeners.before.launch.dapui_config = dapui.open
		dap.listeners.before.event_terminated.dapui_config = dapui.close
		dap.listeners.before.event_exited.dapui_config = dapui.close
	end
}
