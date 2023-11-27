{ pkgs, ... }: {
  imports = [
    ./direnv.nix
    ./gcc.nix
    ./git.nix
    ./neofetch.nix
    ./nodejs.nix
    ./playerctl.nix
    ./pulseaudio.nix
    ./rust.nix
    ./zsh.nix
  ];
}