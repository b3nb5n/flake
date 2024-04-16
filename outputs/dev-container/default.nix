{ pkgs, usrDrv, ... }: {
  dockerContainers.dev-container = pkgs.dockerTools.buildLayeredImage {
    name = "dev-container";
    config.Cmd = [ "${pkgs.zsh}/bin/zsh" "-i" ];
    contents = with pkgs // usrDrv; [ coreutils-full bash zsh dev-env ];
  };
}
