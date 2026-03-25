{ ... }: {
  flake.homeModules.niri = { pkgs, lib, config, ... }:
    let cfg = config.modules.niri;
    in {
      options.modules.niri.enable = lib.mkEnableOption "niri";

      config = lib.mkIf cfg.enable {
        home.packages = with pkgs; [ playerctl ];

        xdg = {
          autostart.enable = true;

          configFile.niri.source = config.lib.file.mkOutOfStoreSymlink
            "${config.dotfiles.path}/niri/.config/niri";

          portal = {
            enable = true;
            config.common.default = "gtk";
            xdgOpenUsePortal = true;
            extraPortals = with pkgs; [
              xdg-desktop-portal-gtk
              xdg-desktop-portal-gnome
              xwayland-satellite
            ];
          };
        };

        services = {
          playerctld.enable = true;

          gnome-keyring = {
            enable = true;
            components = [ "pkcs11" "secrets" ];
          };
        };
      };
    };
}
