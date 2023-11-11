{ pkgs, ... }: {
  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
  
  nix.package = pkgs.nixFlakes;
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  systemd.user.startServices = true;

  home = {
    username = "ben";
    homeDirectory = "/home/ben";
    sessionVariables = {
      EDITOR = "vscode";
      SPAWNEDITOR = "code";
      TERM = "alacritty";
      BROWSER = "firefox";
    };
  };
}
