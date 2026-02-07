flakeInputs: final: prev: let 
  system = final.stdenv.hostPlatform.system;
in {
  self = flakeInputs.self.packages.${system} // {
    lib = let libRoot = flakeInputs.self.lib;
    in libRoot.isolated // libRoot.${system};
  };
}
