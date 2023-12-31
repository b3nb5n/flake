{ pkgs, ... }: {
  home.packages = with pkgs; [
    discord
  ];

  xdg.desktopEntries.discord = {
    name = "Discord";
    genericName = "Discord";
    comment = "All-in-one voice and text chat for gamers that's free, secure, and works on both your desktop and phone.";
    icon = "discord";
    exec = "discord --enable-features=UseOzonePlatform --ozone-platform=wayland %U";
  };
}