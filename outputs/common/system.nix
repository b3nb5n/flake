{ pkgs, ... }: {
  imports = [ ./shared.nix ];

  time.timeZone = "America/Phoenix";
  i18n.defaultLocale = "en_US.UTF-8";

  programs.zsh.enable = true;
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [ vim git ];
}
