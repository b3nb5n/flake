{ pkgs, config, ... }: {
  imports = [ ./shared.nix ../../modules/hm/cli ];

  nix.package = pkgs.nixFlakes;
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = true;

  home = {
    stateVersion = "23.05";
    username = "ben";
    homeDirectory = "/home/${config.home.username}";
  };
}
