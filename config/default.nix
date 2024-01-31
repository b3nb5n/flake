{ usrLib, ... }@args: {
  legacyPackages =
    usrLib.mergeRec [ (import ./bnixdsk args) (import ./dev-container args) ];
}
