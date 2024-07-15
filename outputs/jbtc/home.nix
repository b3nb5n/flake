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
    stateVersion = "24.05";
    username = "jb";
    packages = with pkgs; [ ];
  };
}
