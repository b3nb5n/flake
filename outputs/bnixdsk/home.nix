{ pkgs, ... }: {
  imports = [
    ../../modules/hm/eww
    ../../modules/hm/hypr
    ../../modules/hm/gtk
    ../../modules/hm/local
    ../../modules/hm/gui
    ../../modules/hm/cli
  ];

  home = {
    stateVersion = "23.05";
    username = "ben";
    packages = with pkgs; [ inkscape lmms scarab kicad prismlauncher ];
  };
}
