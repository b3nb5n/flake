{ flakeInputs, pkgs, lib, config, ... }:
let cfg = config.modules.niri;
in {
  options.modules.niri.enable = lib.mkEnableOption "niri";

  config = lib.mkIf cfg.enable {
    xdg = {
      autostart.enable = true;

      configFile.niri.source =
        "${flakeInputs.self.dotfiles.niri}/.config/niri";

      portal = {
        enable = true;
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
}
