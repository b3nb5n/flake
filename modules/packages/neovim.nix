{ self, ... }: {
  perSystem = { pkgs, ... }: {
    packages.neovim = pkgs.symlinkJoin {
      name = "nvim";
      paths = with pkgs; [ neovim ];
      buildInputs = with pkgs; [ makeWrapper ];

      postBuild = let configPath = "${self.dotfiles.neovim}/.config/nvim";
      in ''
        wrapProgram $out/bin/nvim \
          --add-flags "-u \"${configPath}/init.lua\"" \
          --add-flags "--cmd \"set runtimepath^=${configPath}\"" \
          --add-flags "--cmd \"set packpath^=${configPath}\"" \
          --suffix PATH ":" ${
            pkgs.lib.makeBinPath (with pkgs; [
              wl-clipboard
              fzf
              ripgrep
              fd
              yazi
              git
              gcc

              nodePackages.typescript-language-server
              nodePackages.typescript
              vscode-langservers-extracted
              lua-language-server
              bash-language-server
              yaml-language-server
              stable.rust-analyzer
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
            ])
          }
      '';
    };
  };
}
