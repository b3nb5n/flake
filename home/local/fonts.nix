{ pkgs, const, ... }: {
  fonts.fontconfig.enable = true;
  
  home.packages = (with const.theme.font; [
    default.pkg
    serif.pkg
    sans.pkg
    mono.pkg
    emoji.pkg
  ]) ++ (with pkgs; [
    # dejavu_fonts
    # noto-fonts-emoji
  ]);
}