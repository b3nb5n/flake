{ repos, ... }:
let
  nvimPath = "${repos.usrDrv.neovim}/bin/nvim";
in
{
  programs.bash.shellAliases = {
    vim = nvimPath;
    vi = nvimPath;
  };

  programs.zsh.shellAliases = {
    vim = nvimPath;
    vi = nvimPath;
  };

  home.sessionVariables = {
    EDITOR = nvimPath;
    SPAWNEDITOR = nvimPath;
    VISUAL = nvimPath;
  };

  home.packages = [ repos.usrDrv.neovim ];
}
