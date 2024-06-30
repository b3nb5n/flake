{ config, ... }: {
  programs = rec {
    bash.initExtra = zsh.initExtra;
    zsh.initExtra = "${config.programs.fastfetch.package}/bin/fastfetch";

    fastfetch = {
      enable = true;
      settings = { };
    };
  };
}
