{ lib, const, utils, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    extraConfig = with const.theme.colors // utils.theme; ''
      $wmKey = SUPER
      $appKey = CTRL 
      $modKeyA = SHIFT
      $modKeyB = ALT

      # monitor = , preferred, auto, auto

      ${lib.concatStrings
        (lib.lists.imap0
          (i: m: "
            monitor = ${m.name}, ${toString m.width}x${toString m.height}, ${toString m.position.x}x${toString m.position.y}, ${toString m.scale}, transform, ${toString (m.rotation / 90)}
            workspace = ${m.name}, ${toString i}, monitor:${m.name}, default:true, persistent:true
          ")
          const.hardware.monitors)}

      input {
        numlock_by_default = true
      }

      general {
        gaps_in = 6
        gaps_out = 8
        border_size = 2
        col.active_border = rgb(${hex base04})
        col.inactive_border = rgb(${hex base01})
        resize_on_border = true
      }

      decoration {
        rounding = 8
        inactive_opacity = 0.9
        dim_inactive = true
        dim_strength = 0.1
      }

      bind = $wmKey, Escape, exit
      bind = $wmKey, R, exec, hyprctl reload

      bind = $wmKey, left, movefocus, l
      bind = $wmKey, right, movefocus, r
      bind = $wmKey, up, movefocus, u
      bind = $wmKey, down, movefocus, d

      bind = $wmKey $modKeyA, left, swapwindow, l
      bind = $wmKey $modKeyA, right, swapwindow, r
      bind = $wmKey $modKeyA, up, swapwindow, u
      bind = $wmKey $modKeyA, down, swapwindow, d

      binde = $wmKey $modKeyB, right, resizeactive, 16 0
      binde = $wmKey $modKeyB, left, resizeactive, -16 0
      binde = $wmKey $modKeyB, up, resizeactive, 0 -16
      binde = $wmKey $modKeyB, down, resizeactive, 0 16

      bind = $wmKey, Q, killactive
      bind = $wmKey, Return, fullscreen
      bind = $wmKey, A, togglefloating
      bindm = $wmKey, mouse:272, movewindow

      bind = $wmKey, 1, workspace, 1
      bind = $wmKey, 2, workspace, 2
      bind = $wmKey, 3, workspace, 3
      bind = $wmKey, 4, workspace, 4
      bind = $wmKey, 5, workspace, 5
      bind = $wmKey, 6, workspace, 6
      bind = $wmKey, 7, workspace, 7
      bind = $wmKey, 8, workspace, 8
      bind = $wmKey, 9, workspace, 9

      bind = $wmKey $modKeyA, 1, movetoworkspace, 1
      bind = $wmKey $modKeyA, 2, movetoworkspace, 2
      bind = $wmKey $modKeyA, 3, movetoworkspace, 3
      bind = $wmKey $modKeyA, 4, movetoworkspace, 4
      bind = $wmKey $modKeyA, 5, movetoworkspace, 5
      bind = $wmKey $modKeyA, 6, movetoworkspace, 6
      bind = $wmKey $modKeyA, 7, movetoworkspace, 7
      bind = $wmKey $modKeyA, 8, movetoworkspace, 8
      bind = $wmKey $modKeyA, 9, movetoworkspace, 9

      bind = $wmKey, Space, exec, wofi
      windowrule = opacity 0.8, Alacritty

      exec-once = waybar & hyprpaper
    '';
  };
}