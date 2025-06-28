{ flakeInputs, pkgs, ... }:

{ name, modules, homeModules }:

let
  flakeModules = builtins.attrValues flakeInputs.self.nixosModules;

  userConfig = name: homeModule: { isNormalUser = true; };

  baseModule = {
    networking.hostName = name;
    users.users = builtins.mapAttrs userConfig homeModules;
  };

in flakeInputs.nixpkgs.lib.nixosSystem {
  inherit (pkgs) system;
  specialArgs = { inherit flakeInputs; };
  modules = [ baseModule ] ++ modules ++ flakeModules;
}
