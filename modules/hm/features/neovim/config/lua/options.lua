local opt = vim.opt

-- disable default status line
opt.laststatus = 3
opt.showmode = false
opt.ruler = false

-- tab width
opt.expandtab = false
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

-- line numbers
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2

-- searching
opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true
