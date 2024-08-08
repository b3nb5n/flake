{ flakeInputs, pkgs, ... }: {
  nix = {
    enable = true;
    package = pkgs.nixFlakes;
    nixPath = [
      "nixpkgs=${flakeInputs.nixpkgs-stable}"
      "unstable=${flakeInputs.nixpkgs-unstable}"
    ];
    gc.automatic = true;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs = {
    overlays = builtins.attrValues flakeInputs.self.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
}
