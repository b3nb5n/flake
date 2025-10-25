return {
	"gitsigns-nvim",
	event = "UIEnter",
	after = function()
		local gitsigns = require("gitsigns")
		gitsigns.setup()

		vim.keymap.set("n", "<leader>vr", gitsigns.refresh)
		vim.keymap.set("n", "<leader>vh", gitsigns.preview_hunk)

		vim.keymap.set("n", "<leader>nvd", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end)

		vim.keymap.set("n", "<leader>pvd", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end)

		vim.keymap.set("n", "<leader>vS", gitsigns.stage_buffer)
		vim.keymap.set("n", "<leader>vs", gitsigns.stage_hunk)
		vim.keymap.set("v", "<leader>vs", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end)

		vim.keymap.set("n", "<leader>vR", gitsigns.reset_buffer)
		vim.keymap.set("n", "<leader>vr", gitsigns.reset_hunk)
		vim.keymap.set("v", "<leader>vr", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end)

		vim.keymap.set("n", "<leader>vB", gitsigns.blame)
		vim.keymap.set("n", "<leader>vb", function()
			gitsigns.blame_line({
				full = true,
				ignore_whitespace = true,
			})
		end)

		vim.keymap.set({ "o", "x" }, "ivd", gitsigns.select_hunk)
		vim.keymap.set({ "o", "x" }, "avd", gitsigns.select_hunk)
	end,
}
