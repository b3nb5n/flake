{ pkgs, lib, config, ... }: {
  nix.package = pkgs.nixFlakes;
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = true;
  home.homeDirectory = lib.mkDefault "/home/${config.home.username}";
}
