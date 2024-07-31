{ pkgs, lib, ... }: {
  imports = [ ./status-bar.nix ./menu-stystem.nix ./menu-player.nix ];

  home.packages = with pkgs; [ eww jq bc ];

  xdg.configFile = {
    ewwYuck.target = "eww/eww.yuck";
    ewwScss = {
      target = "eww/eww.scss";
      text = # scss
        ''
          $bg: #1f2335;
          $fg: #c0caf5;
          $interactive: #292e42;
          $hover: #414868;
          $active: #7dcfff;

          * {
            all: unset;
          }
        '';
    };
  } // (builtins.listToAttrs (builtins.concatMap (path:
    let
      baseName =
        "eww/icons/workspace/${lib.removeSuffix ".svg" (baseNameOf path)}";
    in [
      {
        name = "${baseName}-active.svg";
        value.text = builtins.replaceStrings [ "#000000" ] [ "#1f2335" ]
          (builtins.readFile path);
      }
      {
        name = "${baseName}-inactive.svg";
        value.text = builtins.replaceStrings [ "#000000" ] [ "#c0caf5" ]
          (builtins.readFile path);
      }
    ]) (lib.filesystem.listFilesRecursive ./icons/workspace)))
    // (builtins.listToAttrs (builtins.concatMap (path:
      let
        baseName =
          "eww/icons/status/${lib.removeSuffix ".svg" (baseNameOf path)}";
      in [
        {
          name = "${baseName}-active.svg";
          value.text = builtins.replaceStrings [ "#000000" "#FF0000" ] [
            "#c0caf5"
            "#1f2335"
          ] (builtins.readFile path);
        }
        {
          name = "${baseName}-inactive.svg";
          value.text = builtins.replaceStrings [ "#000000" ] [ "#c0caf5" ]
            (builtins.readFile path);
        }
        {
          name = "${baseName}-disabled.svg";
          value.text = builtins.replaceStrings [ "#000000" ] [ "#1f2335" ]
            (builtins.readFile path);
        }
      ]) (lib.filesystem.listFilesRecursive ./icons/status)))
    // (builtins.listToAttrs (builtins.concatMap (path: [{
      name = "eww/icons/action/${baseNameOf path}";
      value.text = builtins.replaceStrings [ "#000000" ] [ "#c0caf5" ]
        (builtins.readFile path);
    }]) (lib.filesystem.listFilesRecursive ./icons/action)));

  wayland.windowManager.hyprland.settings = let ewwBin = "${pkgs.eww}/bin/eww";
  in {
    exec-once = [ "${ewwBin} daemon && ${ewwBin} open status-bar" ];
    bind = [ "SUPER, Return, exec, ${ewwBin} open --toggle launch-menu " ];
  };
}
