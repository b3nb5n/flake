{ flakeInputs, pkgs, ... }:

{ name, modules }:

let
  flakeModules = builtins.attrValues flakeInputs.self.nixosModules;

  baseModule = {
    networking.hostName = name;
  };
in

flakeInputs.nixpkgs.lib.nixosSystem {
  inherit (pkgs) system;
  specialArgs = { inherit flakeInputs; };
  modules = [ baseModule ] ++ modules ++ flakeModules;
}
