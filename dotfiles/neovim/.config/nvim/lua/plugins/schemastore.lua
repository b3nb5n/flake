return {
	"schemastore-nvim",
	ft = { "json", "jsonc", "yaml" },
	after = function()
		local schemastore = require("schemastore")

		vim.lsp.config("jsonls", {
			settings = {
				json = {
					schemas = schemastore.json.schemas(),
					validate = { enable = true },
				},
			},
		})

		vim.lsp.config("yamlls", {
			settings = {
				yaml = {
					schemaStore = { enable = false, url = "" },
					schemas = schemastore.yaml.schemas(),
				},
			},
		})
	end,
}
