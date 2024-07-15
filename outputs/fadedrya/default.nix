{ flakeInputs, pkgs, ... }@args: {
  homeConfigurations = {
    "ben@fadedrya" = flakeInputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = args;
      modules = [ ./shared.nix ../common/home.nix ./home.nix ];
    };
  };
}
