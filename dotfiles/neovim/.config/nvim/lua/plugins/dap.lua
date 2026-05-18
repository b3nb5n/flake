return {
	"nvim-dap",
	event = "DeferredUIEnter",
	after = function()
		local dap = require("dap")
		local dap_utils = require("dap.utils")

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

		-- Node
		dap.adapters["pwa-node"] = {
			type = "server",
			host = "127.0.0.1",
			port = 3866,
			executable = {
				command = "js-debug",
				args = { "3866", "127.0.0.1" },
			},
			options = {
				source_filetype = "typescript"
			},
		}

		local node_configuration = {
			type = "pwa-node",
			showAsyncStacks = true,
			skipFiles = { "<node_internals>/**", "**/node_modules/**" },
		}

		dap.configurations["javascript"] = {
			vim.tbl_extend("force", node_configuration, {
				request = "launch",
				name = "Debug file with node",
				program = "${file}",
				runtimeArgs = { "--experimental-specifier-resolution=node" }
			}),

			vim.tbl_extend("force", node_configuration, {
				request = "attach",
				name = "Debug node process",
				processId = dap_utils.pick_process,
			})
		}

		dap.configurations["typescript"] = {
			vim.tbl_extend("force", node_configuration, {
				request = "launch",
				name = "Debuf file with ts-node",
				program = "${file}",
				runtimeExecutable = "npx ts-node -y",
				runtimeArgs = { "--", "--transpile-only", "--esm" },
			})
		}
	end
}
