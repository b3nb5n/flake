{ pkgs, ... }: {
  imports = [
    ./font.nix
    ./gnome.nix
    ./wofi.nix
    ./cursor.nix
    ./discord.nix
    ./firefox.nix
    ./alacritty.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [ qalculate-gtk spotify cinnamon.nemo ];
}
