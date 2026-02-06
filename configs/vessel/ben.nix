{ pkgs, ... }: {
  home = {
    stateVersion = "25.05";
    packages = with pkgs; [ 
      eza
      fd
      ripgrep
      fzf
      jq
      procs
      btop
      zip
      unzip
      stable.termscp
      systemctl-tui 
      wiki-tui 
      ttyper

      gnome-calculator
      gnome-calendar
      gnome-maps
      gnome-weather
      spotify
      helvum 
      blueberry
      inkscape
      blender
      discord

      olympus
      prismlauncher
    ];
  };

  modules = {
    agenix.enable = true;
    alacritty.enable = true;
    direnv.enable = true;
    fastfetch.enable = true;
    firefox.enable = true;
    fonts.enable = true;
    git.enable = true;
    gtk.enable = true;
    mako.enable = true;
    neovim.enable = true;
    niri.enable = true;
    walker.enable = true;
    yazi.enable = true;
    zsh.enable = true;

    ssh = {
      enable = true;
      matchFlakeHosts.wyrm.port = 999;
    };
  };
}
