{ flakeInputs, pkgs, ... }: {
  hardware.enableAllFirmware = true;

  time.timeZone = "America/Phoenix";
  i18n.defaultLocale = "en_US.UTF-8";

  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;
  };

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
    optimise.automatic = true;
    gc.automatic = true;
    nixPath = [
      "nixpkgs=${flakeInputs.nixpkgs-stable}"
      "unstable=${flakeInputs.nixpkgs-unstable}"
    ];
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  networking = {
    firewall.enable = true;
    networkmanager.enable = true;
  };

  services = {
    fstrim.enable = true;
  };

  programs = {
    zsh.enable = true;
    dconf.enable = true;
  };
}
