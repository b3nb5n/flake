{ pkgs, ... }: {
  imports = [ ./gnome.nix ./wofi.nix ./firefox.nix ./alacritty.nix ];

  home.packages = with pkgs; [ spotify webcord helvum ];
}
