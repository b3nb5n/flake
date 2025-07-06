{ pkgs, ... }: {
  home = {
    stateVersion = "25.05";
    packages = with pkgs; [ systemctl-tui wiki-tui helvum ];
  };

  modules = {
    agenix.enable = true;
    autostart.enable = true;
    alacritty.enable = true;
    direnv.enable = true;
    fastfetch.enable = true;
    firefox.enable = true;
    git.enable = true;
    gnome.enable = true;
    gtk.enable = true;
    hyprland.enable = true;
    neovim.enable = true;
    osteo.enable = true;
    spotify.enable = true;
    wbg.enable = true;
    wofi.enable = true;
    yazi.enable = true;

    ssh = {
      enable = true;
      matchFlakeHosts.wyrm.port = 999;
    };
  };

  wayland.windowManager.hyprland.settings.monitor =
    [ "DP-2, 3840x2160, 0x0, 1.5" ];
}
