{ ... }: {
  flake.homeModules.neovim = { pkgs, lib, config, ... }:
    let cfg = config.modules.neovim;
    in {
      options.modules.neovim = { enable = lib.mkEnableOption "neovim"; };

      config = lib.mkIf cfg.enable {
        home.packages = with pkgs; [
          neovim

          wl-clipboard
          ripgrep
          fd
          gcc

          nodePackages.typescript-language-server
          nodePackages.typescript
          vscode-langservers-extracted
          lua-language-server
          bash-language-server
          yaml-language-server
          rust-analyzer
          gotools
          nixd
          sqls
          taplo

          rustfmt
          nodePackages.prettier
          nixfmt-classic
          shfmt
          gofumpt
          stylua
          yamlfmt

          vscode-extensions.vadimcn.vscode-lldb.adapter
          vscode-js-debug
        ];

        xdg = {
          configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink
            "${config.dotfiles.path}/neovim/.config/nvim";

          dataFile.nvim-pack = {
            target = "nvim/site/pack/vendor";
            source = config.lib.file.mkOutOfStoreSymlink
              "${config.dotfiles.path}/neovim/.local/share/nvim/site/pack/vendor";
          };
        };
      };
    };
}
