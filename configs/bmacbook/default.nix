flakeInputs: {
  darwinConfigurations.bmacbook = flakeInputs.nix-darwin.lib.darwinSystem {
    system = "aarch64-darwin";
    modules = [ ./system.nix ];
    specialArgs = { inherit flakeInputs; };
  };

  homeConfigurations."ben@bmacbook" =
    flakeInputs.home-manager.lib.homeManagerConfiguration {
      inherit (flakeInputs.self.darwinConfigurations.bmacbook) pkgs;
      modules = [ ../base/home.nix ./home.nix ];
      extraSpecialArgs = { inherit flakeInputs; };
    };
}
