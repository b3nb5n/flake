{ usrLib, ... }@args: {
  legacyPackages = usrLib.mergeRec [
    (import ./bmacbook args)
    (import ./bnixdsk args)
    (import ./dev-container args)
    (import ./fadedrya args)
  ];
}
