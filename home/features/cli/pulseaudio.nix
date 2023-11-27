{ pkgs, ... }: {
  home.packages = with pkgs; [
    pulseaudio
  ];
}