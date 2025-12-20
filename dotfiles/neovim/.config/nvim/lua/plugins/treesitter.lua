return {
	"nvim-treesitter",
	event = "UIEnter",
	after = function()
		local parser_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "parsers")
		vim.opt.rtp:prepend(parser_dir)

		local keymaps = function(key, selector, mode)
			return {
				select = {
					keymaps = {
						["<leader>a" .. key] = selector .. ".outer",
						["<leader>i" .. key] = selector .. ".inner",
					},
					selection_modes = {
						[selector .. ".outer"] = mode or "v",
						[selector .. ".inner"] = mode or "v",
					},
				},
				move = {
					goto_next_start = {
						["<leader>n" .. key] = selector .. ".outer",
						["<leader>n" .. key .. "o"] = selector .. ".outer",
						["<leader>n" .. key .. "i"] = selector .. ".inner",
					},
					goto_next_end = {
						["<leader>n" .. key .. "e"] = selector .. ".outer",
					},
					goto_previous_start = {
						["<leader>p" .. key] = selector .. ".outer",
						["<leader>p" .. key .. "o"] = selector .. ".outer",
						["<leader>p" .. key .. "i"] = selector .. ".inner",
					},
					goto_previous_end = {
						["<leader>p" .. key .. "e"] = selector .. ".outer",
					},
				},
				swap = {
					swap_next = {
						["<leader>m" .. key] = selector .. ".inner",
						["<leader>mn" .. key] = selector .. ".inner",
					},
					swap_previous = {
						["<leader>mp" .. key] = selector .. ".inner",
					},
				},
			}
		end

		---@diagnostic disable-next-line: missing-fields
		require("nvim-treesitter.configs").setup({
			sync_install = false,
			auto_install = false,
			parser_install_dir = parser_dir,
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",

				"xml",
				"yaml",
				"json",
				"jsonc",

				"html",
				"css",
				"scss",
				"styled",
				"javascript",
				"jsdoc",
				"typescript",
				"tsx",

				"bash",
				"c",
				"cpp",
				"c_sharp",
				"python",
				"sql",
				"nix",
				"rust",
			},

			highlight = {
				enable = true,
			},

			indent = {
				enable = true,
			},

			textobjects = vim.tbl_deep_extend(
				"keep",
				{
					select = { enable = true },
					move = { enable = true },
					swap = { enable = true },
				},
				keymaps("m", "@assignment"),
				keymaps("a", "@attribute"),
				keymaps("s", "@block"),
				keymaps("i", "@call"),
				keymaps("c", "@class", "V"),
				keymaps("d", "@comment"),
				keymaps("b", "@conditional"),
				keymaps("f", "@function", "V"),
				keymaps("l", "@loop", "V"),
				keymaps("p", "@parameter"),
				keymaps("r", "@return")
			),
		})
	end,
}
