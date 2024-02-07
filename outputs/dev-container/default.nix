{ pkgs, usrDrv, ... }: {
  dockerContainers.dev-container = pkgs.dockerTools.buildLayeredImage {
    name = "dev-container";
    contents = [ usrDrv.dev-env ];
    config = { Cmd = "${pkgs.zsh}/bin/zsh"; };
  };
}
