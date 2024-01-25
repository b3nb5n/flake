return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				filetypes = { "lua" },
			})

			lspconfig.html.setup({
				capabilities = capabilities,
				filetypes = { "html" },
			})

			lspconfig.tsserver.setup({
				capabilities = capabilities,
				filetypes = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
			})

			lspconfig.bashls.setup({
				capabilities = capabilities,
				filetypes = { "sh" },
			})

			lspconfig.gopls.setup({
				capabilities = capabilities,
				filetypes = { "go", "gomod" },
			})

			lspconfig.nil_ls.setup({
				capabilities = capabilities,
				filetypes = { "nix" },
			})

			--			lspconfig.rust_analyzer.setup({
			--				capabilities = capabilities,
			--				filetypes = { "rust" },
			--			})

			vim.keymap.set("n", "<leader>?", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>re", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "<leader>fmt", vim.lsp.buf.format, {})

			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function()
					vim.lsp.buf.format({ async = false })
				end,
			})
		end,
	},
}
