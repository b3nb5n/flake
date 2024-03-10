{ pkgs, ... }: {
  imports = [
    ../../modules/shared/themes/basic.nix
    ../../modules/shared/hardware/options.nix
  ];

  nix.package = pkgs.nixFlakes;
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      allowUnsupportedSystem = true;
    };
  };

  #hardwareInfo.monitors = [
  #];
}
