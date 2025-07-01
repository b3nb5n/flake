{ pkgs, ... }: {
  home = {
    stateVersion = "25.05";
    packages = with pkgs; [ systemctl-tui ];
  };

  modules = {
    agenix.enable = true;
    alacritty.enable = true;
    direnv.enable = true;
    fastfetch.enable = true;
    firefox.enable = true;
    git.enable = true;
    gtk.enable = true;
    hyprland.enable = true;
    neovim.enable = true;
    osteo.enable = true;
    spotify.enable = true;
    wbg.enable = true;
    wofi.enable = true;
    yazi.enable = true;
  };
}
