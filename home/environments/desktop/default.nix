{ pkgs, ... }: {
  imports = [
    ../base.nix

    ./eww
    ./gtk.nix
    ./hyprland.nix
    ./hyprpaper.nix
    ./wofi.nix
  ];

  home = {
    packages = with pkgs; [
      xdg-utils
    ];
    sessionVariables = {
      EDITOR = "vscode";
      SPAWNEDITOR = "code";
      TERM = "alacritty";
      BROWSER = "firefox";
    };
  };
}