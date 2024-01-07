{ lib, usrLib, config, ... }: {
  # home.sessionVariables.NIXOS_OZONE_WL = "1";

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = with config.hardwareInfo // config.theme // usrLib.color; {
      monitor = map
        (m: "${m.name}, ${toString m.width}x${toString m.height}, ${toString m.x}x${toString m.y}, ${toString m.scale}, transform, ${toString (m.rotation / 90)}")
        monitors;
      
      workspace = lib.lists.imap0
        (i: m: "${m.name}, ${toString i}, monitor:${m.name}, default:true, persistent:true")
        monitors;

      input = {
        numlock_by_default = true;
        accel_profile = "flat";
      };

      general = {
        gaps_in = gap.sm;
        gaps_out = gap.md;
        border_size = 2;
        resize_on_border = true;
        # "col.active_border" = "rgb(${lib.strings.removePrefix "#" (hex (builtins.elemAt color.fg 0))})";
        "col.inactive_border" = "rgba(00000000)";
      };

      decoration = {
        rounding = 8;
        inactive_opacity = 0.9;
        dim_inactive = true;
        dim_strength = 0.1;
      };

      "$wmKey" = "SUPER";
      "$appKey" = "CTRL";
      "$modKeyA" = "SHIFT";
      "$modKeyB" = "ALT";

      bind = [
        "$wmKey, Escape, exit"
        "$wmKey, R, exec, hyprctl reload"
        "$wmKey, Q, killactive"
        "$wmKey, F, fullscreen"
        "$wmKey, A, togglefloating"
        "$wmKey, Space, exec, wofi"

        "$wmKey, left, movefocus, l"
        "$wmKey, right, movefocus, r"
        "$wmKey, up, movefocus, u"
        "$wmKey, down, movefocus, d"

        "$wmKey $modKeyA, left, swapwindow, l"
        "$wmKey $modKeyA, right, swapwindow, r"
        "$wmKey $modKeyA, up, swapwindow, u"
        "$wmKey $modKeyA, down, swapwindow, d"

        "$wmKey $modKeyB, right, resizeactive, 16 0"
        "$wmKey $modKeyB, left, resizeactive, -16 0"
        "$wmKey $modKeyB, up, resizeactive, 0 -16"
        "$wmKey $modKeyB, down, resizeactive, 0 16"

        "$wmKey, 1, workspace, 1"
        "$wmKey, 2, workspace, 2"
        "$wmKey, 3, workspace, 3"
        "$wmKey, 4, workspace, 4"
        "$wmKey, 5, workspace, 5"
        "$wmKey, 6, workspace, 6"
        "$wmKey, 7, workspace, 7"
        "$wmKey, 8, workspace, 8"
        "$wmKey, 9, workspace, 9"

        "$wmKey $modKeyA, 1, movetoworkspace, 1"
        "$wmKey $modKeyA, 2, movetoworkspace, 2"
        "$wmKey $modKeyA, 3, movetoworkspace, 3"
        "$wmKey $modKeyA, 4, movetoworkspace, 4"
        "$wmKey $modKeyA, 5, movetoworkspace, 5"
        "$wmKey $modKeyA, 6, movetoworkspace, 6"
        "$wmKey $modKeyA, 7, movetoworkspace, 7"
        "$wmKey $modKeyA, 8, movetoworkspace, 8"
        "$wmKey $modKeyA, 9, movetoworkspace, 9"

        ",XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
        ",XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
        ",XF86AudioMute, exec, amixer ssset 'Master' toggle"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPrev, exec, playerctl previous"
      ];

      binde = [
        "$wmKey $modKeyB, right, resizeactive, 16 0"
        "$wmKey $modKeyB, left, resizeactive, -16 0"
        "$wmKey $modKeyB, up, resizeactive, 0 -16"
        "$wmKey $modKeyB, down, resizeactive, 0 16"
      ];

      bindm = [
        "$wmKey, mouse:272, movewindow"
      ];

      windowrule = [
        "opacity 0.8, Alacritty"
        "opacity 0.8, qalculate-gtk"
        "float, qalculate-gtk"
      ];

      exec-once = [
        "hyprpaper"
        "eww daemon && (${lib.strings.concatMapStringsSep
          " & " (m: "eww open ${m.name}-status-bar") monitors})"
      ];
    };
  };
}
