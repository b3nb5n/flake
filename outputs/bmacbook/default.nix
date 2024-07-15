{ flakeInputs, pkgs, ... }@args: {
  darwinConfigurations.bmacbook = flakeInputs.nix-darwin.lib.darwinSystem {
    inherit pkgs;
    inherit (pkgs) system;
    specialArgs = args;
    modules = [ ./shared.nix ./system.nix ];
  };

  homeConfigurations."ben@bmacbook" =
    flakeInputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = args;
      modules = [ ./shared.nix ./home.nix ];
    };
}
