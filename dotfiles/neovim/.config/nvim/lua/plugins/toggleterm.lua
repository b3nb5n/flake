return {
	"toggleterm-nvim",
	event = "DeferredUIEnter",
	after = function()
		local toggleterm = require("toggleterm")
		local terminal = require("toggleterm.terminal")

		toggleterm.setup({
			direction = "float",
			float_opts = { border = "curved" },
		})

		vim.keymap.set("n", "<leader>ot", "<cmd>ToggleTerm<cr>")
		vim.keymap.set("n", "<leader>ft", "<cmd>TermSelect<cr>")

		if vim.fn.executable("lazygit") then
			local lazygit = terminal.Terminal:new({
				cmd = "lazygit",
				hidden = true,
			})

			vim.keymap.set("n", "<leader>og", function()
				lazygit:open()
			end)
		end

		-- local select_terminal = function(callback)
		-- 	local terminals = terminal.get_all()
		-- 	if #terminals == 0 then
		-- 		local term = terminal.Terminal:new()
		-- 		callback(term, term.id)
		-- 		return
		-- 	end
		--
		-- 	if #terminals == 1 then
		-- 		callback(terminals[1], 1)
		-- 		return
		-- 	end
		--
		-- 	vim.ui.select(terminals, {
		-- 		prompt = "Select a terminal to execute the command in: ",
		-- 		format_item = function(term)
		-- 			return term.id .. ": " .. term:_display_name()
		-- 		end,
		-- 	}, callback)
		-- end

		-- vim.keymap.set({ "n", "v" }, "<leader>x", function()
		-- 	select_terminal(function(term)
		-- 		if not term then return end
		--
		-- 		local select_mode
		-- 		local mode = vim.fn.mode()
		-- 		if mode == "n" then
		-- 			select_mode = "single_line"
		-- 		elseif mode == "v" then
		-- 			select_mode = "visual_selection"
		-- 		elseif mode == "V" then
		-- 			select_mode = "visual_lines"
		-- 		end
		--
		-- 		if not select_mode then return end
		-- 		toggleterm.send_lines_to_terminal(select_mode, true, {
		-- 			args = term.id
		-- 		})
		--
		-- 		if term:is_open() then
		-- 			term:focus()
		-- 		else
		-- 			term:open()
		-- 		end
		-- 	end)
		-- end)
	end,
}
