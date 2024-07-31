flakeInputs: {
  nixosConfigurations.jbtc = flakeInputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [ ../base/system.nix ./system.nix ];
    specialArgs = { inherit flakeInputs; };
  };

  homeConfigurations."jb@jbtc" =
    flakeInputs.home-manager.lib.homeManagerConfiguration {
      inherit (flakeInputs.self.nixosConfigurations.jbtc) pkgs;
      modules = [ ../base/home.nix ./home.nix ];
      extraSpecialArgs = { inherit flakeInputs; };
    };
}
