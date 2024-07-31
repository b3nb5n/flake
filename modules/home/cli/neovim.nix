{ pkgs, ... }:
let nvimPath = "${pkgs.neovim}/bin/nvim";
in {
  programs = rec {
    bash.shellAliases = zsh.shellAliases;
    zsh.shellAliases = {
      vi = nvimPath;
      vim = nvimPath;
    };
  };

  home = {
    packages = [ pkgs.neovim ];
    sessionVariables = {
      SPAWNEDITOR = nvimPath;
      VISUAL = nvimPath;
    };
  };
}
