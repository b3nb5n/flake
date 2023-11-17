{ pkgs, ... }: {
  imports = [
    ./git.nix
    ./nodejs.nix
    ./rust.nix
  ];

  home.packages = with pkgs; [
    neofetch
  ];
}