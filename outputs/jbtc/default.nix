{ flakeInputs, pkgs, ... }@args: {
  nixosConfigurations.jbtc = flakeInputs.nixpkgs-unstable.lib.nixosSystem {
    # inherit pkgs;
    inherit (pkgs) system;
    specialArgs = pkgs.lib.filterAttrs (k: _: k != "pkgs") args;
    modules = [ ./system.nix ];
  };

  homeConfigurations = {
    "jb@jbtc" = flakeInputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = args;
      modules = [ ./home.nix ];
    };
  };
}
