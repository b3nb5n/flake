{ config, ... }: {
  programs = rec {
    bash.initExtra = zsh.initExtra;
    zsh.initExtra = /* sh */ ''
      if [[ "$TERMINAL" == *"$TERM" ]]; then
      	${config.programs.fastfetch.package}/bin/fastfetch
      fi
    '';

    fastfetch = {
      enable = true;
      settings = { };
    };
  };
}
