{ pkgs, ... }: {
  nix = {
    gc.automatic = true;
    optimise.automatic = true;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  time.timeZone = "America/Phoenix";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [ vim git ];

  programs.zsh.enable = true;
  programs.dconf.enable = true;
}
