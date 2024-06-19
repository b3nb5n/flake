{ pkgs, usrLib, config, ... }: {
  home = {
    pointerCursor = {
      name = if usrLib.theme.isDarkTheme config.theme then
        "Bibata-Modern-Classic"
      else
        "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
      gtk.enable = true;
    };
  };
}
