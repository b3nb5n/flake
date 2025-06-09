{ pkgs, lib, config, ... }:
let cfg = config.modules.fastfetch;
in {
  options.modules.fastfetch = {
    enable = lib.mkEnableOption "fastfetch";
  };

  config = lib.mkIf cfg.enable {
    programs = rec {
      bash.initExtra = zsh.initExtra;
      zsh.initContent = /* sh */ ''
        if [[ "$TERMINAL" == *"$TERM" ]]; then
        	${config.programs.fastfetch.package}/bin/fastfetch
        fi
      '';

      fastfetch = {
        enable = true;
        package = pkgs.self.fastfetch;
      };
    };
  };
}
