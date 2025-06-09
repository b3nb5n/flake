local jump_recenter_thresh = 0

vim.api.nvim_create_autocmd({ "WinResized", "BufEnter" }, {
	callback = function()
		local height = vim.api.nvim_win_get_height(0)
		jump_recenter_thresh = math.floor(height / 2)
	end,
})

local previous_buf = 0
local previous_row = 0

vim.api.nvim_create_autocmd("CursorMoved", {
	callback = function()
		local buf = vim.fn.bufnr("%")
		local row = vim.fn.line(".")

		local buf_jump = buf ~= previous_buf
		local row_jump = math.abs(row - previous_row)

		previous_buf = buf
		previous_row = row

		if buf_jump then
			return
		end

		if row_jump >= jump_recenter_thresh then
			vim.cmd.normal("zz")
		end
	end,
})
