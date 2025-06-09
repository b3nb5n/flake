{ flakeInputs, neovim, pkgs, lib, symlinkJoin, makeWrapper, ... }:

let configPath = "${flakeInputs.self.dotfiles.neovim}/.config/nvim";
in symlinkJoin {
  name = "neovim";
  paths = [ neovim ];
  buildInputs = [ makeWrapper ];

  # --add-flags "--cmd \"set runtimepath^=${configPath}\"" \
  # --add-flags "--cmd \"set packpath^=${configPath}\"" \

  # --set NIX_NVIM_RTP "${configPath}" \
  # --add-flags "-u \"${configPath}/init.lua\"" \

  postBuild = ''
    wrapProgram $out/bin/nvim \
    --suffix PATH ":" ${
      lib.makeBinPath (with pkgs; [
        wl-clipboard
        fzf
        ripgrep
        fd
        yazi
        git
        gcc

        vscode-langservers-extracted
        typescript-language-server
        lua-language-server
        bash-language-server
        yaml-language-server
        rust-analyzer
        nixd
        sqls
        taplo

        gotools
        rustfmt
        nixfmt
        shfmt
        gofumpt
        stylua
        yamlfmt
      ])
    }
  '';
}
