{ pkgs, config, ... }: {
  nix.package = pkgs.nixFlakes;
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  programs.home-manager.enable = true;
  home = {
    stateVersion = "23.05";
    username = config.custom.user.name;
    homeDirectory = "/home/${config.custom.user.name}";
    packages = with pkgs; [
      xdg-utils
    ];
  };

  systemd.user.startServices = true;
}