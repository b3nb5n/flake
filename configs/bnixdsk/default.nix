flakeInputs: flakeInputs.self.lib."x86_64-linux".mkSystem {
  name = "bnixdsk";

  users = {
    root = [ ./root.nix ];
    ben = [ ./ben.nix ];
  };
}
