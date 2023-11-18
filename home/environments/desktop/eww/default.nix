{ stdenv, pkgs, lib, const, utils, ... }: {
  home.packages = with pkgs; [
    eww-wayland
  ];

  imports = [
    ./assets
    ./scripts
  ];

  xdg.configFile."eww/widgets.yuck".source = ./widgets.yuck;
  xdg.configFile."eww/eww.yuck".text = ''
    (include "./widgets.yuck")

    ${lib.concatStrings (lib.lists.imap0
      (i: m: ''
        (deflisten ${m.name}-workspaces "hyprland-workspaces ${m.name}")
        (defwindow ${m.name}-status-bar
          :monitor ${toString i}
          :stacking "fg"
          :exclusive true
          :focusable false
          :geometry (geometry
            :x "0%"
            :y "8px"
            :width "100%"
            :height "36px"
            :anchor "top center"
          )
          (status-bar :workspaces ${m.name}-workspaces)
        )
      '')
      const.hardware.monitors)
    }
  '';

  xdg.configFile."eww/eww.scss".text = with const.theme.colors // utils.theme; ''
    .widget-group {
      padding: 4px 8px;
      border-radius: 4px;
      background: #${hex base01};
      color: #${hex base05};
    }

    .home-icon {
      padding: 0px 8px;
    }

    .workspace-button {
      all: unset;
      padding: 0px 12px;
      background: #${hex base01};
      color: #${hex base05};

      &:hover {
        background: #${hex base02}
      }

      &.active {
        background: #${hex base0D};
        color: #${hex base00};
        outline: #${hex base01} inset 2px;
      }
    }

    .workspace-group button:first-child {
      border-top-left-radius: 4px;
      border-bottom-left-radius: 4px;
    }

    .workspace-group button:last-child {
      border-top-right-radius: 4px;
      border-bottom-right-radius: 4px;
    }

    window {
      background: transparent;
    }

    .status-bar {
      margin: 0px 8px;
      padding: 6px;
      background: #${hex base00};
      border-radius: 8px;
    }
  '';
}