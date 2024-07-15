{ repos, ... }:
let nvimPath = "${repos.usrDrv.neovim}/bin/nvim";
in {
  programs = rec {
    bash.shellAliases = zsh.shellAliases;
    zsh.shellAliases = {
      vim = nvimPath;
      vi = nvimPath;
    };
  };

  home.sessionVariables = {
    EDITOR = nvimPath;
    SPAWNEDITOR = nvimPath;
    VISUAL = nvimPath;
  };

  home.packages = [ repos.usrDrv.neovim ];
}
