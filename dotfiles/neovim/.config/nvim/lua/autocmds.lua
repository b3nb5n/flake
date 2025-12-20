vim.api.nvim_create_autocmd(
	{ "FocusGained", "BufEnter", "VimResume" },
	{ command = "checktime" }
)

vim.api.nvim_create_autocmd("BufLeave", {
	callback = function(args)
		local bo = vim.bo[args.buf]
		if bo.buftype or bo.readonly then
			return
		end

		vim.api.nvim_buf_call(args.buf, vim.cmd.write)
	end,
})

local jump_recenter_thresh = 0

vim.api.nvim_create_autocmd({ "WinResized", "BufEnter" }, {
	callback = function()
		local height = vim.api.nvim_win_get_height(0)
		jump_recenter_thresh = math.floor(height * 0.3)
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
