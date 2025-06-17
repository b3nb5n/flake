vim.g.mapleader = " "

vim.keymap.set({ "n", "v", "i" }, "<c-s>", vim.cmd.write)

vim.keymap.set("t", "<s-esc>", "<c-\\><c-n>")
vim.keymap.set({ "n", "v", "t" }, "<c-esc>", function()
	if vim.bo.buftype then
		vim.cmd.close()
	end
end)

vim.keymap.set("n", "<c-q>", function()
	vim.cmd.wall()
	vim.cmd.qall()
end)

vim.keymap.set("n", "Q", function()
	vim.cmd.wall()
	vim.cmd("%bd")
end)
