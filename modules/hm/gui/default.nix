{ pkgs, ... }: {
  imports = [
    ./gnome.nix
    ./wofi.nix
    ./firefox.nix
    ./alacritty.nix
    # ./vscode.nix
  ];

  home.packages = with pkgs; [ spotify webcord ];
}
