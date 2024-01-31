{ flakeInputs, pkgs, ... }:
(flakeInputs.nixvim.legacyPackages.${pkgs.system}.makeNixvim {
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
      key = "<leader>sh";
      action = "<cmd>lua vim.lsp.buf.hover() vim.lsp.buf.hover()<CR>";
    }
    {
      key = "<leader>tt";
      action = "<cmd>Neotree filesystem focus toggle left<CR>";
    }
    {
      key = "<leader>tr";
      action = "<cmd>Neotree filesystem focus reveal left<CR>";
    }
    {
      key = "<leader>git";
      action = "<cmd>LazyGit<CR>";
    }
    {
      key = "<leader>db";
      action = "<cmd>DapToggleBreakpoint<CR>";
    }

    {
      key = "<leader>dq";
      action = "<cmd>DapTerminate<CR>";
    }
    {
      key = "<leader>dr";
      action = "<cmd>DapRestartFrame<CR>";
    }
    {
      key = "<leader>dc";
      action = "<cmd>DapContinue<CR>";
    }
    {
      key = "<leader>di";
      action = "<cmd>DapStepInto<CR>";
    }
    {
      key = "<leader>do";
      action = "<cmd>DapStepOut<CR>";
    }
    {
      key = "<leader>ds";
      action = "<cmd>DapStepOver<CR>";
    }
  ];

  plugins = {
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
      ];
    };

    neo-tree = {
      enable = true;
      eventHandlers = {
        file_opened = ''function() vim.cmd("Neotree close") end'';
      };
    };

    lualine.enable = true;

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
        # rust-analyzer.enable = true; # installed by rustaceanvim
      };
      keymaps = {
        lspBuf = {
          "<leader>sa" = "code_action";
          "<leader>sd" = "definition";
          "<leader>su" = "document_highlight";
          # "<leader>sh" = "hover"; # declared in global keybinds
          "<leader>sr" = "rename";
          "<leader>st" = "type_definition";
          "<leader>fmt" = "format";
        };
        diagnostic = {
          # "<leader>dn" = "goto_next";
          # "<leader>dp" = "goto_prev";
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
        "<leader>fk" = "keymaps";
        "<leader>fc" = "commands";
        "<leader>fm" = "man_pages";
        "<leader>fh" = "help_tags";

        "<leader>ff" = "find_files";
        "<leader>fg" = "live_grep";
        "<leader>fb" = "buffers";
        "<leader>fd" = "diagnostics";
        "<leader>fl" = "current_buffer_fuzzy_find";

        "<leader>fs" = "lsp_document_symbols";
        "<leader>fsr" = "lsp_references";
        "<leader>fsi" = "lsp_incoming_calls";
        "<leader>fso" = "lsp_outgoing_calls";
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

    lsp-format.enable = true;
    markdown-preview.enable = true;
    ts-autotag.enable = true;
    # nvim-autopairs.enable = true;
  };

  clipboard.providers.wl-copy.enable = true;

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
