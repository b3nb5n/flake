return {
	"yazi-nvim",
	event = "DeferredUIEnter",
	enabled = function ()
		return vim.fn.executable("yazi") == 1
	end,
	after = function()
		local yazi = require("yazi")

		yazi.setup({
			open_for_directories = true,
		})

		vim.g.loaded_netrwPlugin = 1

		-- vim.api.nvim_set_fl(0, "YaziFloat", { bg = colors.bg_dark })

		vim.keymap.set({ "n", "v" }, "<leader>of", "<cmd>Yazi<cr>")
		vim.keymap.set({ "n", "v" }, "<leader>oF", "<cmd>Yazi cwd<cr>")
	end,
}
