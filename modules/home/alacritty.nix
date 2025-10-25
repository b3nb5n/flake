{ flakeInputs, pkgs, lib, config, ... }:
let cfg = config.modules.alacritty;
in {
  options.modules.alacritty = { 
    enable = lib.mkEnableOption "alacritty"; 

    package = lib.mkPackageOption pkgs [ "alacritty" ] {};
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package pkgs.nerd-fonts.atkynson-mono ];

    xdg = {
      autostart.entries = [ "${cfg.package}/share/applications/Alacritty.desktop" ];
      configFile.alacritty.source =
        "${flakeInputs.self.dotfiles.alacritty}/.config/alacritty";
    };
  };
}
