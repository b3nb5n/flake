{ pkgs, ... }: {
  home.packages = with pkgs; [
    pkgs.cinnamon.nemo
  ];
}