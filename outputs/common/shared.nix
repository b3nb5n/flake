{ pkgs, lib, ... }: {
  nix = {
    enable = true;
    package = pkgs.nixFlakes;
    gc.automatic = true;
    optimise.automatic = true;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      nvidia.acceptLicense = true;
    };
  };
}
