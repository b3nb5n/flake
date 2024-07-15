{ pkgs, repos, ... }: {
  imports = [
    ./shared.nix
    ../../modules/hm/eww
    ../../modules/hm/hypr
    ../../modules/hm/gtk
    ../../modules/hm/local
    ../../modules/hm/gui
    ../../modules/hm/cli
  ];

  nix.package = pkgs.nixFlakes;
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = true;
  home = rec {
    stateVersion = "23.05";
    username = "ben";
    homeDirectory = "/home/${username}";
    packages = with pkgs // repos.usrDrv; [
      inkscape
      lmms
      scarab
      kicad
	  prismlauncher
    ];
  };
}
