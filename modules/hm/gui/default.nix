{ pkgs, ... }: {
  imports = [
    ./gnome.nix
    ./wofi.nix
    ./discord.nix
    ./firefox.nix
    ./alacritty.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [ qalculate-gtk spotify cinnamon.nemo ];
}
