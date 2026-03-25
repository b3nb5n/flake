{ ... }: {
  flake.homeModules.hyprland = { pkgs, lib, config, ... }:
    let cfg = config.modules.hyprland;
    in {
      options.modules.hyprland = {
        enable = lib.mkEnableOption "hyprland";
      };

      config = lib.mkIf cfg.enable {
        xdg.portal = {
          enable = true;
          extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
          xdgOpenUsePortal = true;
        };

        wayland.windowManager.hyprland = {
          enable = true;
          systemd = {
            enable = true;
            enableXdgAutostart = true;
          };
          settings = {
            monitor = [ ", preferred, auto, 1.5" ];
            animations.enabled = false;

            workspace = [
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
              focus_on_activate = true;
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
                key = "KP_Left";
              }
              {
                name = "messaging";
                key = "KP_End";
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
              "$wmKey, h, movefocus, l"
              "$wmKey, l, movefocus, r"
              "$wmKey, k, movefocus, u"
              "$wmKey, j, movefocus, d"

              "$wmKey $modKeyA, left, swapwindow, l"
              "$wmKey $modKeyA, right, swapwindow, r"
              "$wmKey $modKeyA, up, swapwindow, u"
              "$wmKey $modKeyA, down, swapwindow, d"
              "$wmKey $modKeyA, h, swapwindow, l"
              "$wmKey $modKeyA, l, swapwindow, r"
              "$wmKey $modKeyA, k, swapwindow, u"
              "$wmKey $modKeyA, j, swapwindow, d"
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
              "$wmKey $modKeyB, l, resizeactive, 16 0"
              "$wmKey $modKeyB, h, resizeactive, -16 0"
              "$wmKey $modKeyB, k, resizeactive, 0 -16"
              "$wmKey $modKeyB, j, resizeactive, 0 16"
            ];

            bindm = [ "$wmKey, mouse:272, movewindow" ];

            windowrulev2 = let
              pictureInPicture =
                "class:^(firefox)$, title:^(Picture-in-Picture)$";
            in [
              "workspace name:terminal silent, class:(Alacritty)"
              "workspace name:browser silent, class:(firefox)"
              "workspace name:media silent, class:(Spotify)"

              "float, ${pictureInPicture}"
              "pin, ${pictureInPicture}"
              "size 640 360, ${pictureInPicture}"
              "move 100%-w-16 72, ${pictureInPicture}"
              "noinitialfocus, ${pictureInPicture}"
            ];

            layerrule = [ "blur, menu-system" "ignorezero, menu-system" ];

            env = [
              "XDG_CURRENT_DESKTOP, Hyprland"
              "XDG_SESSION_DESKTOP, Hyprland"
            ];

            # exec-once = [
            #     "[workspace name:terminal silent] $TERMINAL"
            #     "[workspace name:browser silent] $BROWSER"
            #     "[workspace name:media silent] spotify"
            #     "[workspace name:messaging silent] webcord"
            #   ];
          };
        };

        # systemd.user.services.tag-autostart-clients =
        #   let
        #     inherit (config.wayland.windowManager) hyprland;
        #     mkService = hyprland.enable && hyprland.systemd.enable && hyprland.systemd.enableXdgAutostart;
        #     hyprctl = "${hyprland.package}/bin/hyprctl";
        #   in
        #   lib.mkIf mkService {
        #     Unit = {
        #       Description = "tag automatically started clients";
        #       After = [ "graphical-session-pre.target" "xdg-desktop-autostart.target" ];
        #     };
        #
        #     Install = {
        #       WantedBy = [ "xdg-desktop-autostart.target" ];
        #     };
        #
        #     Service = {
        #       type = "oneshot";
        #       ExecStart = pkgs.writeShellScript "tag-autostart-clients" ''
        #         clients = $(${hyprctl} clients -j | jq -r '.[].class')
        #         for class in $clients; do
        #           ${hyprctl} dispatch tagwindow "+autostart" "class:^($class)$"
        #         done
        #       '';
        #     };
        #   };
      };
    };
}
