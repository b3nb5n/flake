flakeInputs: final: prev: {
  self = flakeInputs.self.packages.${final.system} // {
    lib = let libRoot = flakeInputs.self.lib;
    in libRoot.isolated // libRoot.${final.system};
  };
}
