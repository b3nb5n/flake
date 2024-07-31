{ pkgs, lib, ... }: {
  xdg.desktopEntries.cubemx= {
    name = "STM32 CubeMX";
    genericName = "STM32 CubeMX";
    icon = "discord";
    exec = "${pkgs.stm32cubemx}/bin/stm32cubemx";
  };
}
