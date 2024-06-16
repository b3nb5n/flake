{ pkgs, repos, ... }: {
  dockerContainers.dev-container = pkgs.dockerTools.buildLayeredImage {
    name = "dev-container";
    config.Cmd = [ "${pkgs.zsh}/bin/zsh" "-i" ];
    contents = with pkgs // repos.usrDrv; [
      coreutils-full
      bash
      zsh
      dev-env
    ];
  };
}
