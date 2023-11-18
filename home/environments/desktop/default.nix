{ pkgs, const, config, ... }: {
  imports = [
    ../base.nix

    ./eww
    ./gtk.nix
    ./hyprland.nix
    ./hyprpaper.nix
    ./wofi.nix
  ];

  home = {
    sessionVariables = {
      EDITOR = "vscode";
      SPAWNEDITOR = "code";
      TERM = "alacritty";
      BROWSER = "firefox";
    };
    packages = with pkgs; [
      bibata-cursors
    ];
    pointerCursor = {
      name = if const.theme.dark then "Bibata-Modern-Classic" else "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
      gtk.enable = true;
    };
  };

  systemd.user.startServices = true;
}