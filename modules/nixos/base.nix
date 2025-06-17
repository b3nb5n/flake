{ flakeInputs, pkgs, ... }: {
  nixpkgs = {
    overlays = builtins.attrValues flakeInputs.self.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
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

  nix = {
    enable = true;
    package = pkgs.nixVersions.stable;
    optimise.automatic = true;
    gc.automatic = true;
    nixPath = [
      "nixpkgs=${flakeInputs.nixpkgs-stable}"
      "unstable=${flakeInputs.nixpkgs-unstable}"
    ];
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
}
