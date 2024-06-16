{ flakeInputs, pkgs, repos, usrLib, ... }:
(flakeInputs.nixvim.legacyPackages.${pkgs.system}.makeNixvim {
  extraConfigLua = builtins.readFile ./neovim.lua;

  globals = { mapleader = " "; };

  opts = {
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
    conceallevel = 1;
    signcolumn = "yes";
  };

  keymaps = [
    {
      mode = [ "n" "v" "i" ];
      key = "<c-s>";
      action = "<cmd>w<CR>";
    }
    {
      mode = "n";
      key = "<c-esc>";
      action = "<cmd>noh<cr>";
    }
    {
      mode = "t";
      key = "<c-esc>";
      action = "<c-\\><c-n>";
    }
    {
      key = "<leader>ot";
      action = "<cmd>terminal<cr>";
    }
    {
      key = "<leader>of";
      action = "<cmd>terminal ${pkgs.lf}/bin/lf<cr>";
    }
    {
      key = "<leader>og";
      action = "<cmd>terminal ${pkgs.lazygit}/bin/lazygit<cr>";
    }
    {
      key = "<leader>oh";
      action = "<cmd>terminal ${pkgs.wuzz}/bin/wuzz<cr>";
    }
    {
      key = "<leader>os";
      action = "<cmd>terminal ${repos.usrDrv.lazysql}/bin/lazysql<cr>";
    }
    {
      key = "<leader>fg";
      action.__raw = "require('telescope.builtin').live_grep";
    }
    {
      key = "<leader>fl";
      action.__raw = "require('telescope.builtin').current_buffer_fuzzy_find";
    }
    {
      key = "<leader>ff";
      action.__raw = ''
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
      action.__raw = ''
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
      action.__raw =
        "function() require('telescope.builtin').diagnostics({ sort_by = 'severity' }) end";
    }
    {
      key = "<leader>fw";
      action.__raw = "require('telescope.builtin').spell_suggest";
    }
    {
      key = "<leader>sr";
      action.__raw = "require('telescope.builtin').lsp_references";
    }
    {
      key = "<leader>sd";
      action.__raw = "require('telescope.builtin').lsp_definitions";
    }
    {
      key = "<leader>st";
      action.__raw = "require('telescope.builtin').lsp_type_definitions";
    }
    {
      key = "<leader>db";
      action = "<cmd>DapToggleBreakpoint<CR>";
    }
    {
      key = "<leader>ts";
      action = "<cmd>:setlocal spell! spelllang=en_us<cr>";
    }
  ];

  autoCmd = [
    {
      event = "TermOpen";
      callback.__raw = ''
          function()
        	vim.opt_local.number = false
        	vim.opt_local.relativenumber = false
        	vim.opt_local.signcolumn = "no"
        	vim.cmd("startinsert")
          end
      '';
    }
    {
      event = "TermClose";
      command = "bdelete";
    }
  ];

  clipboard.providers.wl-copy.enable = true;

  colorschemes.tokyonight = {
    enable = true;
    settings = {
      style = "night";
      styles.keywords.italic = false;
    };
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
      sections = {
        lualine_x = [{
          fmt = ''
            function(text)
            	return text .. require("lsp-status").status()
            end
          '';
        }];
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

    treesitter-textobjects = let
      keymaps = selector: key: {
        move = {
          gotoNextStart = {
            "<leader>n${key}" = "@${selector}.outer";
            "<leader>n${key}o" = "@${selector}.outer";
            "<leader>n${key}i" = "@${selector}.inner";
          };
          gotoPreviousStart = {
            "<leader>p${key}" = "@${selector}.outer";
            "<leader>p${key}o" = "@${selector}.outer";
            "<leader>p${key}i" = "@${selector}.inner";
          };
          gotoNextEnd."<leader>n${key}e" = "@${selector}.outer";
          gotoNextEnd."<leader>p${key}e" = "@${selector}.outer";
        };
        select.keymaps = {
          "<leader>va${key}" = "@${selector}.outer";
          "<leader>vi${key}" = "@${selector}.inner";
        };
      };
    in usrLib.mergeRec [
      {
        enable = true;
        move.enable = true;
        select.enable = true;
        swap.enable = true;
      }
      (usrLib.mergeRec [
        (keymaps "assignment" "a")
        # (bindings "attribute" "a")
        (keymaps "block" "s") # scope
        (keymaps "call" "i") # invocation
        (keymaps "class" "c")
        (keymaps "comment" "d") # documentation
        (keymaps "conditional" "b") # branch
        (keymaps "function" "f")
        (keymaps "loop" "l")
        (keymaps "parameter" "p")
        (keymaps "return" "r")
      ])
    ];

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
          "<leader>sn" = "rename";
          "<leader>sh" = "hover";
          # "<leader>sd" = "definition"; # done with telescope
          # "<leader>st" = "type_definition"; # done with telescope
        };
        diagnostic = {
          "<leader>ne" = "goto_next";
          "<leader>pe" = "goto_prev";
          "<leader>se" = "open_float";
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
        stylua.enable = true;
        sqlfluff.enable = true;
      };
    };

    luasnip.enable = true;
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        completion.complete_opt =
          "menu,menuone,preview,noinsert,noselect,fuzzy";
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
          "<c-n>" = "cmp.mapping.select_next_item()";
          "<c-p>" = "cmp.mapping.select_prev_item()";
          "<cr>" = "cmp.mapping.confirm()";
          "<esc>" = "cmp.mapping.close()";
        };
      };
    };

    telescope = {
      enable = true;
      extensions.ui-select.enable = true;
      settings.defaults = {
        file_ignore_patterns = [ ".git/" ".direnv/" "target/" "node_modules/" ];
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
      settings.dap = {
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

    comment.enable = true;
    nvim-autopairs.enable = true;
    ts-autotag.enable = true;
    surround.enable = true;
    treesitter-context.enable = true;
    vim-css-color.enable = true;
    lspkind.enable = true;
    lsp-status.enable = true;
    gitsigns.enable = true;
  };
})
