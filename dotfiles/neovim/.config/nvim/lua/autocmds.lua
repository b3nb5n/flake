vim.api.nvim_create_autocmd(
	{ "FocusGained", "BufEnter", "VimResume" },
	{ command = "checktime" }
)

local previous_win = 0
local previous_buf = 0
local previous_line = 0

vim.api.nvim_create_autocmd("CursorMoved", {
	callback = function(event)
		local window_id = vim.api.nvim_get_current_win()
		local window_height = vim.api.nvim_win_get_height(window_id)
		local buffer_height = vim.api.nvim_buf_line_count(event.buf)
		local cursor_line = vim.api.nvim_win_get_cursor(window_id)[1]

		local window_equal = window_id == previous_win
		local buffer_equal = event.buf == previous_buf
		local buffer_overflow = buffer_height > window_height

		if window_equal and buffer_equal and buffer_overflow then
			local recenter_threshold = math.floor(window_height * 0.4)
			local line_jump = math.abs(cursor_line - previous_line)

			if line_jump > recenter_threshold then
				vim.cmd.normal("zz")
			end
		end

		previous_win = window_id
		previous_buf = event.buf
		previous_line = cursor_line
	end,
})

vim.api.nvim_create_autocmd("BufLeave", {
	callback = function(args)
		local bo = vim.bo[args.buf]
		if bo.buftype or bo.readonly then
			return
		end

		vim.api.nvim_buf_call(args.buf, vim.cmd.write)
	end,
})
