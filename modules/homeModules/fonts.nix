{ ... }: {
  flake.homeModules.fonts = { pkgs, lib, config, ... }:
    let cfg = config.modules.fonts;
    in {
      options.modules.fonts = { enable = lib.mkEnableOption "fonts"; };

      config = lib.mkIf cfg.enable {
        home.packages = with pkgs; [
          dejavu_fonts
          nerd-fonts.atkynson-mono
          noto-fonts-color-emoji
        ];

        fonts.fontconfig = {
          enable = true;
          antialiasing = true;

          defaultFonts = {
            serif = [ "DejaVu Serif" ];
            sansSerif = [ "DejaVu Sans" ];
            monospace = [ "AtkynsonMono Nerd Font Mono" ];
            emoji = [ "Noto Color Emoji" ];
          };
        };
      };
    };
}
