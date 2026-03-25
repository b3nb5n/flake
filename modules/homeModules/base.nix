{ self, ... }: {
  flake.homeModules.base = { pkgs, config, ... }: {
    nix = {
      enable = true;
      package = pkgs.nixVersions.stable;
      settings.experimental-features = [ "nix-command" "flakes" ];
    };

    nixpkgs = {
      overlays = builtins.attrValues self.overlays;
      config.allowUnfree = true;
    };

    home.homeDirectory =
      let dir = if !pkgs.stdenv.isDarwin then "home" else "Users";
      in "/${dir}/${config.home.username}";

    programs.home-manager.enable = true;
    systemd.user.startServices = true;

    xdg = {
      enable = true;
      userDirs.enable = true;
    };
  };
}

