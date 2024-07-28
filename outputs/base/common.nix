{ flakeInputs, pkgs, ... }: {
  nix = {
    enable = true;
    package = pkgs.nixFlakes;
    gc.automatic = true;
    # optimise.automatic = true;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs = {
    overlays = builtins.attrValues flakeInputs.self.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      nvidia.acceptLicense = true;
    };
  };
}
