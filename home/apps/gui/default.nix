{ pkgs, ... }: {
  imports = [
    ./alacritty.nix
    ./firefox.nix
    ./fuzzel.nix
    ./nemo.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    spotify
  ];
}