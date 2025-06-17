return {
	"fzf-lua",
	event = "DeferredUIEnter",
	after = function()
		local fzf = require("fzf-lua")
		local utils = require("fzf-lua.utils")

		fzf.setup({
			winopts = {
				title_flags = false,
				treesitter = true,
				preview = {
					winopts = {
						number = false,
						cursorline = false,
						scrolloff = 8,
					},
				},
			},
			fd_opts = [[--color=never --type f --hidden --follow --exclude .git/ .direnv/ node_modules/ target/ ]],
		})

		fzf.register_ui_select()

		vim.keymap.set("n", "<leader>ff", fzf.files)
		vim.keymap.set("n", "<leader>fb", fzf.buffers)
		vim.keymap.set("n", "<leader>fr", fzf.resume)
		vim.keymap.set("n", "<leader>fk", fzf.keymaps)
		vim.keymap.set("n", "<leader>fh", fzf.helptags)
		vim.keymap.set("n", "<leader>fo", fzf.nvim_options)
		vim.keymap.set("n", "<leader>fw", fzf.spell_suggest)

		vim.keymap.set("n", "<leader>fg", fzf.live_grep)
		vim.keymap.set("n", "<leader>fG", fzf.live_grep)

		vim.keymap.set("v", "<leader>fg", function()
			local search = utils.get_visual_selection()
			fzf.grep({ search = search })
		end)

		vim.keymap.set("n", "<leader>fgp", function()
			fzf.live_grep({ rg_glob = true })
		end)

		vim.keymap.set("n", "<leader>fl", fzf.lgrep_curbuf)
		vim.keymap.set("n", "<leader>fL", fzf.lgrep_curbuf)

		vim.keymap.set("v", "<leader>fl", function()
			local search = utils.get_visual_selection()
			fzf.lgrep_curbuf({ search = search })
		end)

		vim.keymap.set("n", "<leader>flp", function()
			fzf.lgrep_curbuf({ rg_glob = true })
		end)

		vim.keymap.set("n", "<leader>sr", fzf.lsp_references)
		vim.keymap.set("n", "<leader>sd", fzf.lsp_definitions)
		vim.keymap.set("n", "<leader>st", fzf.lsp_typedefs)

		vim.keymap.set("n", "<leader>fvc", fzf.git_commits)
		vim.keymap.set("n", "<leader>fvb", fzf.git_branches)
		vim.keymap.set("n", "<leader>fvs", fzf.git_stash)

		vim.keymap.set("n", "<leader>fe", fzf.diagnostics_workspace)
		vim.keymap.set("n", "<leader>fE", function()
			fzf.diagnostics_workspace({
				severity_only = vim.diagnostic.severity.ERROR,
			})
		end)

		vim.keymap.set("n", "<leader>fge", fzf.diagnostics_workspace)
		vim.keymap.set("n", "<leader>fgE", function()
			fzf.diagnostics_workspace({
				severity_only = vim.diagnostic.severity.ERROR,
			})
		end)

		vim.keymap.set("n", "<leader>fle", fzf.diagnostics_document)
		vim.keymap.set("n", "<leader>flE", function()
			fzf.diagnostics_document({
				severity_only = vim.diagnostic.severity.ERROR,
			})
		end)
	end,
}
