{ self, ... }: {
  flake.nixosModules.base = { pkgs, ... }: {
    nix = {
      enable = true;
      package = pkgs.nixVersions.stable;
      optimise.automatic = true;
      gc.automatic = true;
      settings.experimental-features = [ "nix-command" "flakes" ];
    };

    nixpkgs = {
      overlays = builtins.attrValues self.overlays;
      config.allowUnfree = true;
    };

    hardware.enableAllFirmware = true;

    time.timeZone = "America/Phoenix";
    i18n.defaultLocale = "en_US.UTF-8";

    users.mutableUsers = false;

    networking = {
      firewall.enable = true;
      networkmanager.enable = true;
    };

    services.fstrim.enable = true;
    programs.dconf.enable = true;
  };
}
