{ flakeInputs, pkgs, config, ... }: {
  home.homeDirectory =
    let dir = if !pkgs.stdenv.isDarwin then "home" else "Users";
    in "/${dir}/${config.home.username}";

  nixpkgs = {
    overlays = builtins.attrValues flakeInputs.self.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  nix = {
    enable = true;
    package = pkgs.nixVersions.stable;
    nixPath = [
      "nixpkgs=${flakeInputs.nixpkgs-stable}"
      "unstable=${flakeInputs.nixpkgs-unstable}"
    ];
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  systemd.user.startServices = true;
  xdg.enable = true;

  programs = {
    home-manager.enable = true;
  };
}
