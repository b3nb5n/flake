{ pkgs, repos, ... }: {
  imports = [
    ./shared.nix
    ../../modules/hm/environments/hyprland
    ../../modules/hm/features
    ../../modules/hm/local
  ];

  nix.package = pkgs.nixFlakes;
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  programs.home-manager.enable = true;
  home = rec {
    stateVersion = "23.05";
    username = "ben";
    homeDirectory = "/home/${username}";
    packages = with pkgs // repos.usrDrv; [
      blueberry
      hyprpicker
      inkscape
      cinnamon.nemo
      lmms
      playerctl
      pulseaudio # do I actually need this here?
      qalculate-gtk
      spotify
      scarab
      kicad
      helvum
      lf
      ttyper
      neomutt
      sic
    ];
  };

  systemd.user.startServices = true;
}
