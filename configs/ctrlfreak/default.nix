flakeInputs: {
  nixosConfigurations.ctrlfreak = flakeInputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [ ../base/system.nix ./system.nix ];
    specialArgs = { inherit flakeInputs; };
  };

  homeConfigurations."ben@ctrlfreak" =
    flakeInputs.home-manager.lib.homeManagerConfiguration {
      inherit (flakeInputs.self.nixosConfigurations.ctrlfreak) pkgs;
      modules = [ ../base/home.nix ./home.nix ];
      extraSpecialArgs = { inherit flakeInputs; };
    };
}

