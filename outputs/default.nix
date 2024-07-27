{ usrLib, repos, ... }@args: {
  legacyPackages = usrLib.mergeRec [
    (import ./bmacbook args)
    (import ./bnixdsk args)
    (import ./fadedrya args)
    (import ./jbtc args)
    { pkgs = repos.usrDrv; }
  ];
}
