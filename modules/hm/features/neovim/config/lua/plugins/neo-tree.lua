return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      window = {
        hijack_netrw_behavior = "open_current",
      },
      event_handlers = {
        {
          event = "file_opened",
          handler = function()
            vim.cmd("Neotree close")
          end,
        },
      },
    })

    vim.keymap.set("n", "<leader>bs", ":Neotree filesystem focus left<CR>", {})
    vim.keymap.set("n", "<leader>bh", ":Neotree filesystem show toggle<CR>", {})
    vim.keymap.set("n", "<leader>ba", ":Neotree filesystem focus left reveal<CR>", {})
  end,
}
