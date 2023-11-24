{ pkgs, const, ... }: {
  nix.package = pkgs.nixFlakes;
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  programs.home-manager.enable = true;
  home = {
    stateVersion = "23.05";
    username = const.user.name;
    homeDirectory = "/home/${const.user.name}";
  };

  systemd.user.startServices = true;
}