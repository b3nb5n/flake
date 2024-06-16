{ flakeInputs, pkgs, ... }@args: {
  nixosConfigurations.bnixdsk = flakeInputs.nixpkgs-unstable.lib.nixosSystem {
    inherit pkgs;
    inherit (pkgs) system;
    specialArgs = args;
    modules = [ ./system.nix ];
  };

  homeConfigurations = {
    "ben@bnixdsk" = flakeInputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = args;
      modules = [ ./home.nix ];
    };
  };
}
