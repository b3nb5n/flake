{ flakeInputs, pkgs, usrDrv, ... }:
(flakeInputs.nixvim.legacyPackages.${pkgs.system}.makeNixvim {
  extraConfigLua = builtins.readFile ./neovim.lua;

  globals = { mapleader = " "; };

  options = {
    termguicolors = true;

    number = true;
    relativenumber = true;
    scrolloff = 8;

    tabstop = 4;
    softtabstop = 4;
    shiftwidth = 4;
    expandtab = false;
    smartindent = true;

    swapfile = false;
  };

  keymaps = [
    {
      key = "<C-s>";
      action = "<cmd>w<CR>";
      mode = [ "n" "v" "i" ];
    }
    {
      mode = "t";
      key = "<c-esc>";
      action = "<C-\\><C-n>";
    }
    {
      key = "<leader>tt";
      action = "<cmd>terminal<cr>";
    }
    {
      key = "<leader>ex";
      action = "<cmd>terminal ${pkgs.xplr}/bin/xplr<cr>";
    }
    {
      key = "<leader>git";
      action = "<cmd>terminal ${pkgs.lazygit}/bin/lazygit<cr>";
    }
    {
      key = "<leader>http";
      action = "<cmd>terminal ${pkgs.wuzz}/bin/wuzz<cr>";
    }
    # {
    #   key = "<leader>sql";
    #   action = "<cmd>terminal ${usrDrv.lazysql}/bin/lazysql<cr>";
    # }

    {
      key = "<leader>fg";
      lua = true;
      action = "require('telescope.builtin').live_grep";
    }
    {
      key = "<leader>fl";
      lua = true;
      action = "require('telescope.builtin').current_buffer_fuzzy_find";
    }
    {
      key = "<leader>ff";
      lua = true;
      action = ''
        function()
          require('telescope.builtin').find_files({
            hidden = true,
            no_ignore = true,
            no_ignore_parent = true,
          })
        end
      '';
    }
    {
      key = "<leader>fb";
      lua = true;
      action = ''
        function()
          require('telescope.builtin').buffers({
            sort_lastused = true,
            ignore_current_buffer = true,
          })
        end
      '';
    }
    {
      key = "<leader>fe";
      lua = true;
      action =
        "function() require('telescope.builtin').diagnostics({ sort_by = 'severity' }) end";
    }

    {
      key = "<leader>fsr";
      lua = true;
      action = "require('telescope.builtin').lsp_references";
    }
    {
      key = "<leader>fsd";
      lua = true;
      action = "require('telescope.builtin').lsp_definitions";
    }
    {
      key = "<leader>fst";
      lua = true;
      action = "require('telescope.builtin').lsp_type_definitions";
    }
    {
      key = "<leader>db";
      action = "<cmd>DapToggleBreakpoint<CR>";
    }
  ];

  autoCmd = [
    {
      event = "TermOpen";
      command = "startinsert";
    }
    {
      event = "TermOpen";
      command = "setlocal nonumber norelativenumber";
    }
    {
      event = "TermClose";
      command =
        "lua vim.api.nvim_buf_delete(tonumber(vim.fn.expand('<abuf>')), {})";
    }
  ];

  clipboard.providers.wl-copy.enable = true;

  colorschemes.tokyonight = {
    enable = true;
    style = "night";
    styles.keywords.italic = false;
  };

  plugins = {
    alpha = {
      enable = true;
      layout = [
        {
          type = "padding";
          val = 6;
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
      ];
    };

    lualine = {
      enable = true;
      globalstatus = true;
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

    lsp = {
      enable = true;
      servers = {
        bashls.enable = true;
        gopls.enable = true;
        html.enable = true;
        lua-ls.enable = true;
        nil_ls.enable = true;
        tsserver.enable = true;
        taplo.enable = true;
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
        };
        diagnostic = {
          "<leader>en" = "goto_next";
          "<leader>ep" = "goto_prev";
          "<leader>eh" = "open_float";
        };
      };
    };

    lsp-format.enable = true;
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
        trim_newlines.enable = true;
        sqlfluff.enable = true;
        taplo.enable = true;
      };
    };

    cmp-buffer.enable = true;
    cmp-dap.enable = true;
    cmp-nvim-lsp.enable = true;
    cmp-nvim-lsp-signature-help.enable = true;
    cmp-path.enable = true;
    cmp-treesitter.enable = true;
    luasnip.enable = true;
    nvim-cmp = {
      enable = true;
      snippet.expand = "luasnip";
      sources = [
        { name = "nvim_lsp_signature_help"; }
        { name = "luasnip"; }
        { name = "nvim_lsp"; }
        { name = "treesitter"; }
        { name = "path"; }
        { name = "dap"; }
        { name = "buffer"; }
      ];
      mapping = {
        "<C-Space>" = "cmp.mapping.complete()";
        "<CR>" = "cmp.mapping.confirm()";
        "<ESC>" = "cmp.mapping.close()";
        "<Down>" = "cmp.mapping.select_next_item()";
        "<C-j>" = "cmp.mapping.select_next_item()";
        "<Tab>" = "cmp.mapping.select_next_item()";
        "<Up>" = "cmp.mapping.select_prev_item()";
        "<C-k>" = "cmp.mapping.select_prev_item()";
        "<S-Tab>" = "cmp.mapping.select_prev_item()";
      };
    };

    telescope = {
      enable = true;
      defaults = {
        file_ignore_patterns = [ ".git" ".direnv" "target" "node_modules" ];
        vimgrep_arguments = [
          "${pkgs.ripgrep}/bin/rg"
          "--hidden"
          "--color=never"
          "--no-heading"
          "--with-filename"
          "--line-number"
          "--column"
          "--smart-case"
        ];
      };
    };

    dap = {
      enable = true;
      extensions.dap-ui.enable = true;
    };

    rustaceanvim = {
      enable = true;
      rustAnalyzerPackage = pkgs.rust-analyzer;
      dap = {
        autoloadConfigurations = true;
        adapter = rec {
          name = "codelldb";
          type = "server";
          host = "127.0.0.1";
          port = "6866";
          executable = {
            command =
              "${pkgs.vscode-extensions.vadimcn.vscode-lldb.adapter}/bin/codelldb";
            args = [ "--port" port ];
          };
        };
      };
    };

    comment-nvim = {
      enable = true;
      mappings.extra = false;
    };

    ts-autotag.enable = true;
  };
})
