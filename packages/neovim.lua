-- auto recenter after big jumps
local jump_recenter_thresh = 0
local function set_jump_thresh()
	jump_recenter_thresh = math.floor(vim.api.nvim_win_get_height(0) / 2)
end

vim.api.nvim_create_autocmd({ "VimEnter", "WinResized", "BufEnter" }, {
	pattern = "*",
	callback = set_jump_thresh,
})

local previous_row = 0
vim.api.nvim_create_autocmd("CursorMoved", {
	pattern = "*",
	callback = function()
		local row = vim.fn.line(".")
		local row_jump = math.abs(row - previous_row)
		previous_row = row

		if row_jump >= jump_recenter_thresh then
			vim.cmd("normal! zz")
		end
	end,
})

-- snippet completion
local snip = require("luasnip")
vim.keymap.set({ "i", "s" }, "<c-n>", function()
	if snip.expand_or_jumpable() then
		snip.expand_or_jump()
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-p>", function()
	if snip.jumpable(-1) then
		snip.jump(-1)
	end
end, { silent = true })

-- debugger
local dap, dapui = require("dap"), require("dapui")
dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

local lsp_status = require("lsp-status")
lsp_status.register_progress()
