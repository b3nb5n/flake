{ flakeInputs, pkgs, ... }:

{ name, hostName, hostConfig, modules }:

let
  flakeModules = builtins.attrValues flakeInputs.self.homeModules;

  baseModule = {
    home.username = name;
  };
in

flakeInputs.home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  extraSpecialArgs = { inherit flakeInputs hostName hostConfig; };
  modules = [ baseModule ] ++ modules ++ flakeModules;
}

