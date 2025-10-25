{ flakeInputs, neovim, pkgs, lib, symlinkJoin, makeWrapper, ... }:
let configPath = "${flakeInputs.self.dotfiles.neovim}/.config/nvim";
in symlinkJoin {
  name = "neovim";
  paths = [ neovim ];
  buildInputs = [ makeWrapper ];

  postBuild = ''
    wrapProgram $out/bin/nvim \
    --add-flags "-u \"${configPath}/init.lua\"" \
    --add-flags "--cmd \"set runtimepath^=${configPath}\"" \
    --add-flags "--cmd \"set packpath^=${configPath}\"" \
    --suffix PATH ":" ${
      lib.makeBinPath (with pkgs; [
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
}
