{ pkgs, config, ... }: {
  imports = [ ./common.nix ];

  programs.home-manager.enable = true;
  systemd.user.startServices = true;
  home.homeDirectory =
    let dir = if !pkgs.stdenv.isDarwin then "home" else "Users";
    in "/${dir}/${config.home.username}";
}
