return {
	"rustaceanvim",
	ft = { "rust" },
	before = function()
		vim.g.rustaceanvim = {
			server = {
				default_settings = {
					["rust-analyzer"] = {
						cargo = {
							features = "all",
						},
						check = {
							command = "clippy",
							features = "all",
						},
					},
				},
			},
			dap = {
				autoload_configurations = true,
				auto_generate_source_map = true,
				load_rust_types = true,

				adapter = {
					type = "executable";
					name = "codelldb",
					command = "codelldb",
				},
			},
		}
	end,
}
