{ pkgs, ... }: {
  imports = [
    ./gcc.nix
    ./git.nix
    ./nodejs.nix
    ./rust.nix
  ];

  home.packages = with pkgs; [
    neofetch
  ];
}