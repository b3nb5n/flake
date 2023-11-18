{ pkgs, ... }: {
  imports = [
    ./alacritty.nix
    ./firefox.nix
    ./nemo.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    spotify
    blueberry
    foot
  ];
}