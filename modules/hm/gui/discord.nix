{ pkgs, lib, ... }: {
  xdg.desktopEntries.discord = lib.mkIf (!pkgs.stdenv.isDarwin) {
    name = "Discord";
    genericName = "messaging";
    icon = "discord";
    exec = "${pkgs.discord}/bin/discord --enable-features=UseOzonePlatform --ozone-platform=wayland %U";
  };
}
