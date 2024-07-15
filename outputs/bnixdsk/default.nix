{ flakeInputs, pkgs, ... }@args: {
  nixosConfigurations.bnixdsk = flakeInputs.nixpkgs-unstable.lib.nixosSystem {
    inherit pkgs;
    inherit (pkgs) system;
    specialArgs = args;
    modules = [ ./shared.nix ../common/system.nix ./system.nix ];
  };

  homeConfigurations = {
    "ben@bnixdsk" = flakeInputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = args;
      modules = [ ./shared.nix ../common/home.nix ./home.nix ];
    };
  };
}
