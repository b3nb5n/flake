{ pkgs, ... }: {
  home = {
    stateVersion = "25.05";
    packages = with pkgs; [ browsh systemctl-tui nixos-icons ];
  };

  modules = {
    hyprpaper.enable = true;
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
    spotify.enable = true;
    wofi.enable = true;
    yazi.enable = true;
    zsh.enable = true;
  };

  wayland.windowManager.hyprland.settings.monitor =
    [ "DP-2, 3840x2160, 0x0, 1.5" ];
}
