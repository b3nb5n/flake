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
      hyperfine
      wiki-tui 
      ttyper
      tokei
      wiremix
      ffmpeg

      gnome-calculator
      gnome-calendar
      gnome-maps
      gnome-weather
      helvum 
      blueberry
      inkscape
      blender
      discord
      nicotine-plus
      mullvad-vpn
      picard
      vlc
      obsidian

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
    spotify.enable = true;
    swayidle.enable = true;
    udiskie.enable = true;
    walker.enable = true;
    yazi.enable = true;
    zsh.enable = true;

    ssh = {
      enable = true;
      matchFlakeHosts.wyrm.port = 999;
    };
  };
}
