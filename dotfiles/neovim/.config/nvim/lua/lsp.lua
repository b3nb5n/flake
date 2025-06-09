local server_configs = {
	taplo = {},
	jsonls = {},
	yamlls = {},

	bashls = {},
	nixd = {},
	cssls = {},
	sqlls = {},

	lua_ls = {
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
				telemetry = {
					enable = false,
				},
			},
		},
	},
}

for server, config in pairs(server_configs) do
	vim.lsp.config(server, config)
	vim.lsp.enable(server)
end

vim.opt.spell = true
vim.opt.spelllang = "en_us"

vim.diagnostic.config({
	update_in_insert = true,
	virtual_text = true,
	severity_sort = true,
})

vim.keymap.set("n", "<leader>sh", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>sn", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>sa", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>se", vim.diagnostic.open_float)

vim.keymap.set("n", "<leader>ne", function()
	vim.diagnostic.jump({
		count = 1,
		float = false,
		wrap = false,
	})
end)

vim.keymap.set("n", "<leader>nE", function()
	vim.diagnostic.jump({
		count = 1,
		float = false,
		wrap = false,
		severity = vim.diagnostic.severity.ERROR,
	})
end)

vim.keymap.set("n", "<leader>pe", function()
	vim.diagnostic.jump({
		count = -1,
		float = false,
		wrap = false,
	})
end)

vim.keymap.set("n", "<leader>pE", function()
	vim.diagnostic.jump({
		count = -1,
		float = false,
		wrap = false,
		severity = vim.diagnostic.severity.ERROR,
	})
end)

vim.keymap.set("n", "<leader>te", function()
	local enable = not vim.diagnostic.is_enabled({ bufnr = 0 })
	vim.diagnostic.enable(enable, { bufnr = 0 })
	vim.notify("Diagnostics are now " .. (enable and "enabled" or "disabled") .. " locally.")
end)

vim.keymap.set("n", "<leader>tE", function()
	local enable = not vim.diagnostic.is_enabled()
	vim.diagnostic.enable(enable)
	vim.notify("Diagnostics are now " .. (enable and "enabled" or "disabled") .. " globally.")
end)

-- vim.keymap.set("n", "<leader>ts", function()
-- 	local enable = not vim.opt.spell
-- 	vim.opt.spell = enable
-- 	vim.notify("spell check is now " .. (enable and "enabled" or "disabled"))
-- end)

vim.keymap.set("n", "<leader>th", function()
	local enable = not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
	vim.lsp.inlay_hint.enable(enable, { bufnr = 0 })

	local enable_msg = enable and "enabled" or "disabled"
	vim.notify("Inlay hints are " .. enable_msg .. " locally.")
end)

vim.keymap.set("n", "<leader>tH", function()
	local enable = not vim.lsp.inlay_hint.is_enabled()
	vim.lsp.inlay_hint.enable(enable)

	local enable_msg = enable and "enabled" or "disabled"
	vim.notify("Inlay hints are " .. enable_msg .. " globally.")
end)
