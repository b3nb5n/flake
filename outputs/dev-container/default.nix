{ pkgs, usrDrv, ... }: {
  dockerContainers.dev-container = pkgs.dockerTools.buildLayeredImage {
    name = "dev-container";
    contents = [ usrDrv.development ];
    config = { Cmd = "${pkgs.zsh}/bin/zsh"; };
  };
}
