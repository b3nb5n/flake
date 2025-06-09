return {
	"nvim-treesitter",
	event = "UIEnter",
	after = function()
		local parser_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "parsers")
		vim.opt.rtp:prepend(parser_dir)

		local keymaps = function(key, selector)
			return {
				select = {
					keymaps = {
						["<leader>a" .. key] = selector .. ".outer",
						["<leader>i" .. key] = selector .. ".inner",
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
				keymaps("c", "@class"),
				keymaps("d", "@comment"),
				keymaps("b", "@conditional"),
				keymaps("f", "@function"),
				keymaps("l", "@loop"),
				keymaps("p", "@parameter"),
				keymaps("r", "@return")
			),
		})
	end,
}
