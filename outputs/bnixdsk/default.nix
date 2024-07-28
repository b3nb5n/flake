flakeInputs: {
  nixosConfigurations.bnixdsk = flakeInputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [ ../base/system.nix ./system.nix ];
    specialArgs = { inherit flakeInputs; };
  };

  homeConfigurations."ben@bnixdsk" =
    flakeInputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import flakeInputs.nixpkgs { system = "x86_64-linux"; };
      modules = [ ../base/home.nix ./home.nix ];
      extraSpecialArgs = { inherit flakeInputs; };
    };
}
