{ flakeInputs, pkgs, ... }: {
  imports = [ flakeInputs.nixvim.homeManagerModules.nixvim ];

  home.packages = with pkgs; [ lazygit ];

  programs.nixvim = {
    enable = true;

    colorschemes.tokyonight = {
      enable = true;
      style = "night";
      styles.keywords.italic = false;
    };

    options = {
      number = true;
      relativenumber = true;
      scrolloff = 8;

      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      expandtab = false;
      smartindent = true;

      termguicolors = true;

      swapfile = false;
      backup = false;
    };

    globals = { mapleader = " "; };

    keymaps = [
      {
        key = "<C-s>";
        action = "<cmd>w<CR>";
      }
      {
        key = "<leader>git";
        action = "<cmd>LazyGit<CR>";
      }
      {
        key = "<leader>tt";
        action = "<cmd>Neotree filesystem focus toggle left<CR>";
      }
      {
        key = "<leader>tr";
        action = "<cmd>Neotree filesystem focus reveal left<CR>";
      }
    ];

    plugins = {
      lsp-format.enable = true;
      lsp = {
        enable = true;
        servers = {
          bashls.enable = true;
          gopls.enable = true;
          html.enable = true;
          lua-ls.enable = true;
          nil_ls.enable = true;
          tsserver.enable = true;
          # rust-analyzer.enable = true; # installed by rustaceanvim
        };
        keymaps = {
          lspBuf = {
            "<leader>sa" = "code_action";
            "<leader>sd" = "definition";
            "<leader>su" = "document_highlight";
            "<leader>sh" = "hover";
            "<leader>sr" = "rename";
            "<leader>st" = "type_definition";
            "<leader>fmt" = "format";
          };
          diagnostic = {
            "<leader>dn" = "goto_next";
            "<leader>dp" = "goto_prev";
          };
        };
      };

      none-ls = {
        enable = true;
        enableLspFormat = true;
        sources.formatting = {
          gofmt.enable = true;
          goimports.enable = true;
          nixfmt.enable = true;
          prettier = {
            enable = true;
            disableTsServerFormatter = true;
          };
          rustfmt.enable = true;
          stylua.enable = true;
          trim_whitespace.enable = true;
        };
      };

      treesitter = {
        enable = true;
        indent = true;
        ensureInstalled = [
          "html"
          "css"
          "javascript"
          "typescript"
          "tsx"
          "json"
          "jsonc"
          "go"
          "gomod"
          "rust"
          "toml"
          "lua"
          "nix"
          "sql"
          "bash"
          "dockerfile"
          "gitignore"
        ];
      };

      cmp-buffer.enable = true;
      cmp-dap.enable = true;
      cmp-npm.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-nvim-lsp-signature-help.enable = true;
      cmp-path.enable = true;
      cmp-treesitter.enable = true;
      nvim-cmp = {
        enable = true;
        sources = [
          { name = "buffer"; }
          { name = "dap"; }
          { name = "npm"; }
          { name = "nvim_lsp"; }
          { name = "nvim_lsp_signature_help"; }
          { name = "path"; }
          { name = "treesitter"; }
        ];
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<ESC>" = "cmp.mapping.close()";
          "<Down>" = "cmp.mapping.select_next_item()";
          "<Tab>" = "cmp.mapping.select_next_item()";
          "<Up>" = "cmp.mapping.select_prev_item()";
          "<S-Tab>" = "cmp.mapping.select_prev_item()";
        };
      };

      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>fw" = "current_buffer_fuzzy_find";
          "<leader>fb" = "buffers";

          "<leader>fk" = "keymaps";
          "<leader>fc" = "commands";
          "<leader>fm" = "man_pages";
          "<leader>fh" = "help_tags";

          "<leader>fr" = "lsp_references";
          "<leader>fd" = "diagnostics";
          "<leader>fs" = "treesitter";
        };
      };

      alpha = {
        enable = true;
        layout = [
          {
            type = "padding";
            val = 4;
          }
          {
            type = "text";
            opts = {
              hl = "Type";
              position = "center";
            };
            val = [
              "                                                                     "
              "       ████ ██████           █████      ██                     "
              "      ███████████             █████                             "
              "      █████████ ███████████████████ ███   ███████████   "
              "     █████████  ███    █████████████ █████ ██████████████   "
              "    █████████ ██████████ █████████ █████ █████ ████ █████   "
              "  ███████████ ███    ███ █████████ █████ █████ ████ █████  "
              " ██████  █████████████████████ ████ █████ █████ ████ ██████ "
            ];
          }
          {
            type = "padding";
            val = 4;
          }
        ];
      };

      neo-tree = {
        enable = true;
        eventHandlers = {
          file_opened = ''function() vim.cmd("Neotree close") end'';
        };
      };

      lualine.enable = true;

      comment-nvim = {
        enable = true;
        mappings.extra = false;
      };

      crates-nvim.enable = true;
      markdown-preview.enable = true;
      rustaceanvim.enable = true;
      ts-autotag.enable = true;
      nvim-autopairs.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [ nvim-web-devicons lazygit-nvim ];
  };
}
