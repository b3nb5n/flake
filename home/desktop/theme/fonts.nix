{ pkgs, ... }: {
  home.packages = with pkgs; [
    dejavu_fonts
    font-awesome
  ];

  fonts.fontconfig.enable = true;
}