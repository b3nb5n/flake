{ usrDrv, ... }@inputs: {
  programs.bash.shellAliases = {
    vim = "nvim";
    vi = "nvim";
  };

  programs.zsh.shellAliases = {
    vim = "nvim";
    vi = "nvim";
  };

  home.packages = [ usrDrv.neovim ];
}
