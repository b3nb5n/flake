{ lib, config, ... }: {
  imports = [ ./shared.nix ];
  programs.home-manager.enable = true;
  systemd.user.startServices = true;
  home.homeDirectory = lib.mkDefault "/home/${config.home.username}";
}
