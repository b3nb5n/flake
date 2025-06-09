vim.g.mapleader = " "

vim.keymap.set({ "n", "v", "i" }, "<c-s>", vim.cmd.write)
vim.keymap.set("t", "<c-esc>", vim.cmd.close)
vim.keymap.set("t", "<s-esc>", "<c-\\><c-n>")

vim.keymap.set("n", "<c-q>", vim.cmd.wqall)
vim.keymap.set("n", "Q", function()
	vim.cmd("wa | %bd")
end)
