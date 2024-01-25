return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        ensure_installed = {
          "html",
          "css",
          "javascript",
          "typescript",
          "tsx",
          "json",
          "jsonc",

          "go",
          "gomod",

          "rust",
          "toml",

          "lua",
          "nix",
          "sql",
          "bash",
          "dockerfile",
          "gitignore",
        },
        auto_install = false,
        highlight = { enable = true },
      })
    end
  }
}
