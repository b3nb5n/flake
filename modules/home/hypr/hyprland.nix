{ pkgs, config, ... }: {
  programs = {
    # bash.loginExtra = zsh.loginExtra;
    zsh.loginExtra =
      # sh
      ''
        if [ -z "''${WAYLAND_DISPLAY}" ] && [[ "$(tty)" == "/dev/tty1" ]]; then
        	exec dbus-run-session ${config.wayland.windowManager.hyprland.package}/bin/Hyprland
        fi
      '';
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      # monitor = map (m:
      #   "${m.name}, ${toString m.width}x${toString m.height}, ${toString m.x}x${
      #     toString m.y
      #   }, ${toString m.scale}, transform, ${toString (m.rotation / 90)}")
      #   config.hardwareInfo.monitors;
      monitor = [ ", preferred, auto, 1" ];

      workspace =
        # (map (m: "${m.id}, monitor:${m.name}, default:true, persistent:true")
        #   config.hardwareInfo.monitors) ++ 
        [
          "name:terminal, monitor:0, persistent:true, default:true"
          "name:browser, monitor:0, persistent:true"
          "name:media, monitor:0, persistent:true"
          "name:messaging, monitor:0, persistent:true"
          "name:gaming, monitor: 0, persistent:true"
        ];

      input = {
        numlock_by_default = true;
        accel_profile = "flat";
      };

      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 2;
        resize_on_border = true;
        "col.active_border" = "rgb(c0caf5)";
        "col.inactive_border" = "rgb(1a1b26)";
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      decoration = {
        rounding = 8;
        inactive_opacity = 0.9;
        dim_inactive = true;
        dim_strength = 0.1;

        blur = {
          enabled = true;
          size = 8;
          passes = 2;
        };
      };

      "$wmKey" = "SUPER";
      "$appKey" = "CTRL";
      "$modKeyA" = "SHIFT";
      "$modKeyB" = "ALT";

      bind = let
        workspace-bindings = (_args:
          let args = { key = _args.name; } // _args;
          in [
            "$wmKey, ${args.key}, workspace, ${args.name}"
            "$wmKey $modKeyA, ${args.key}, movetoworkspace, ${args.name}"
          ]);
      in (builtins.concatMap workspace-bindings ([
        {
          name = "terminal";
          key = "KP_Down";
        }
        {
          name = "browser";
          key = "KP_Next";
        }
        {
          name = "media";
          key = "KP_End";
        }
        {
          name = "messaging";
          key = "KP_Left";
        }
        {
          name = "gaming";
          key = "KP_Begin";
        }
      ] ++ (builtins.genList (i: { name = toString (i + 1); }) 9))) ++ [
        # "$wmKey, Escape, exit"
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
      ];

      bindl = let
        wpctl = "${pkgs.wireplumber}/bin/wpctl";
        playerctl = "${pkgs.playerctl}/bin/playerctl";
      in [
        ", XF86AudioRaiseVolume, exec, ${wpctl} set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 10%+"
        ", XF86AudioLowerVolume, exec, ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 10%-"
        ", XF86AudioMute, exec, ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle"

        ", XF86AudioPlay, exec, ${playerctl} --player=spotify,firefox play-pause"
        ", XF86AudioNext, exec, ${playerctl} --player=spotify,firefox next"
        ", XF86AudioPrev, exec, ${playerctl} --player=spotify,firefox previous"
      ];

      binde = [
        "$wmKey $modKeyB, right, resizeactive, 16 0"
        "$wmKey $modKeyB, left, resizeactive, -16 0"
        "$wmKey $modKeyB, up, resizeactive, 0 -16"
        "$wmKey $modKeyB, down, resizeactive, 0 16"
      ];

      bindm = [ "$wmKey, mouse:272, movewindow" ];

      windowrulev2 = [
        "float, class:^(firefox)$, title:^(Picture-in-Picture)$"
        "pin,   class:^(firefox)$, title:^(Picture-in-Picture)$"
        "size 800 450, class:^(firefox)$, title:^(Picture-in-Picture)$"
      ];

      layerrule = [ "blur, menu-system" "ignorezero, menu-system" ];

      blurls = [ "menu-system" ];

      # exec-once = [
      #   "[workspace name:terminal silent] $TERMINAL"
      #   "[workspace name:browser silent] $BROWSER"
      #   "[workspace name:media silent] spotify"
      #   "[workspace name:messaging silent] webcord"
      # ];
    };
  };
}
