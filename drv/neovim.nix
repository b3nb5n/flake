{ flakeInputs, pkgs, usrDrv, ... }:
(flakeInputs.nixvim.legacyPackages.${pkgs.system}.makeNixvim {
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
  };

  globals = { mapleader = " "; };

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
      key = "<leader>db";
      action = "<cmd>DapToggleBreakpoint<CR>";
    }
  ];

  colorschemes.tokyonight = {
    enable = true;
    style = "night";
    styles.keywords.italic = false;
  };

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
      keymaps = {
        "<leader>ff" = "find_files";
        "<leader>fg" = "live_grep";
        "<leader>fb" = "buffers";
        "<leader>fe" = "diagnostics";
        "<leader>fl" = "current_buffer_fuzzy_find";

        "<leader>fs" = "lsp_document_symbols";
        "<leader>fsr" = "lsp_references";
        "<leader>fsd" = "lsp_definitions";
        "<leader>fst" = "lsp_type_definitions";

        "<leader>fgc" = "git_commits";
        "<leader>fgb" = "git_branches";
        "<leader>fgs" = "git_stash";
      };
      defaults = {
        file_ignore_patterns = [ "target" "node_modules" ];
        vimgrep_arguments = [
          "${pkgs.ripgrep}/bin/rg"
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
            command ="";
      #        "${pkgs.vscode-extensions.vadimcn.vscode-lldb.adapter}/bin/codelldb";
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

  clipboard.providers.wl-copy.enable = true;

  # extraPlugins = with pkgs.vimPlugins; [ lsp-status-nvim ];

  extraConfigLua = ''
    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.before.attach.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
    end
  '';
})
