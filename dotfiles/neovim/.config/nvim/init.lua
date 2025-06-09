-- local nix_rtp = vim.env.NIX_NVIM_RTP
-- if nix_rtp ~= nil then
-- 	vim.opt.runtimepath:remove(vim.fn.stdpath("config"))
-- 	vim.opt.runtimepath:remove(vim.fn.stdpath("config") .. "/after")
-- 	vim.opt.runtimepath:remove(vim.fn.stdpath("data") .. "/site")
--
-- 	vim.opt.rtp:append(nix_rtp)
-- 	vim.opt.packpath:append(nix_rtp)
-- 	vim.cmd.packloadall()
-- end

require("options")
require("keymaps")
require("autocmds")
require("lsp")

local lzn = require("lz.n")
lzn.load("plugins")
