{ config, pkgs, ... }:
let
  colors = config.colorScheme.colors;
in {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    extraConfig = ''
      $wmKey = SUPER
      $appKey = CTRL 
      $modKeyA = SHIFT
      $modKeyB = ALT

      monitor = , preferred, auto, auto

      input {
        numlock_by_default = true
      }

      general {
        gaps_in = 8
        gaps_out = 12
        border_size = 2
        col.active_border = rgb(${colors.base04})
        col.inactive_border = rgb(${colors.base01})
        resize_on_border = true
      }

      decoration {
        rounding = 8
        inactive_opacity = 0.9
        dim_inactive = true
        dim_strength = 0.1
      }

      windowrule = opacity 0.8, Alacritty

      bind = $wmKey, Escape, exit
      bind = $wmKey, Q, killactive
      bind = $wmKey, R, exec, hyprctl reload

      bind = $wmKey, left, movefocus, l
      bind = $wmKey, right, movefocus, r
      bind = $wmKey, up, movefocus, u
      bind = $wmKey, down, movefocus, d

      binde = $wmKey $modKeyA, left, resizeactive, -16 0
      binde = $wmKey $modKeyA, right, resizeactive, 16 0
      binde = $wmKey $modKeyA, up, resizeactive, 0 -16
      binde = $wmKey $modKeyA, down, resizeactive, 0 16

      bind = $wmKey $modKeyB, left, swapwindow, l
      bind = $wmKey $modKeyB, right, swapwindow, r
      bind = $wmKey $modKeyB, up, swapwindow, u
      bind = $wmKey $modKeyB, down, swapwindow, d

      bind = $wmKey, Space, exec, wofi --show run

      exec-once = waybar & dunst & hyprpaper
    '';
  };
}