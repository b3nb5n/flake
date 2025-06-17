{ flakeInputs, pkgs, ... }:
flakeInputs.astal.lib.mkLuaPackage {
  inherit pkgs;
  name = "osteo";
  src = "${flakeInputs.self.dotfiles.osteo}/.config/osteo";

  extraPackages = with flakeInputs.astal.packages.${pkgs.system}; [
    io
    astal3
    astal4

    apps
    auth
    battery
    bluetooth
    hyprland
    mpris
    network
    wireplumber
  ];
}
