{ repos, ... }: {
  programs.bash.shellAliases = {
    vim = "nvim";
    vi = "nvim";
  };

  programs.zsh.shellAliases = {
    vim = "nvim";
    vi = "nvim";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    SPAWNEDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.packages = [ repos.usrDrv.neovim ];
}
