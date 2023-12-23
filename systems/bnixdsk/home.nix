{ pkgs, config, ... }: {
  nix.package = pkgs.nixFlakes;
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  programs.home-manager.enable = true;
  home = {
    stateVersion = "23.05";
    homeDirectory = "/home/${config.home.username}";
  };

  systemd.user.startServices = true;
}