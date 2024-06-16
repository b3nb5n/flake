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
    EDITOR = "neovim";
    SPAWNEDITOR = "nvim";
  };

  home.packages = [ repos.usrDrv.neovim ];
}
