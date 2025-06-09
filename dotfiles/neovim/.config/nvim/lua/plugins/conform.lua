return {
	"conform-nvim",
	event = "DeferredUIEnter",
	after = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				html = { "prettier" },
				css = { "prettier" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				go = { "gofumpt", "goimports" },
				rust = { "rustfmt" },
				nix = { "nixfmt" },
				lua = { "stylua" },
				sh = { "shfmt" },
				zsh = { "shfmt" },
				sql = { "sqruff" },
				toml = { "taplo" },
				yaml = { "yamlfmt" },
				json = { "prettier" },
				jsonc = { "prettier" },
				markdown = { "markdownlint" },
			},
		})

		vim.g.format_on_save = true
		local function format_on_save_is_enabled(bufnr)
			local enabled_locally = vim.b[bufnr].format_on_save
			if enabled_locally ~= nil then
				return enabled_locally
			end

			return vim.g.format_on_save
		end

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				if format_on_save_is_enabled(args.buf) then
					conform.format({ bufnr = args.buf })
				end
			end,
		})

		vim.keymap.set({ "n", "v" }, "<leader>lf", function()
			conform.format({ async = true })
		end)

		vim.keymap.set("n", "<leader>tf", function()
			local enable = not format_on_save_is_enabled(0)
			vim.b[0].format_on_save = enable

			local msg = enable and "enabled" or "disabled"
			vim.notify("Format on save is now " .. msg .. " locally")
		end)

		vim.keymap.set("n", "<leader>tF", function()
			local enable = not vim.g.format_on_save
			vim.g.format_on_save = enable

			local msg = enable and "enabled" or "disabled"
			vim.notify("Format on save is now " .. msg .. " globally")
		end)
	end,
}
