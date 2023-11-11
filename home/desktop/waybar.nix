{ pkgs, config, ... }: let
  colors = config.colorScheme.colors;
in {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin = "12 12 0 12";
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [];
        modules-right = [
          "cpu"
          "memory"
          "disk"
          "pulseaudio"
          "network"
          "bluetooth"
          "clock"
        ];
        cpu = {
          format = "{usage}% {avg_frequency}GHz  ";
          tooltip = false;
        };
        memory = {
          format = "{used} / {total}GiB  ";
          tooltip = false;
        };
        disk = {
          format = "{used} / {total}  ";
          tooltip = false;
        };
        pulseaudio = {
          format = "{volume}%  {icon}  {format_source}";
          format-muted = "  {format_source}";
          format-source = "";
          format-source-muted = "";
          format-icons.default = [ "" "" "" ];
          tooltip = false;
        };
        network = {
          format = "?";
          format-wifi = "";
          format-ethernet = "";
          format-linked = "";
          format-disconnected = "";
          tooltip = false;
        };
        bluetooth = {
          format = "?";
          format-connected = "";
          format-on = "";
          format-off = "";
          format-disabled = "";
          tooltip = false;
        };
        clock = {
          "format" = "{:%I:%M}";
        };
      };
    };
    style = ''
      * {
        font-family: sans-serif, 'Font Awesome';
        font-size: 16px;
      }

      #waybar {
        background: #${colors.base00};
        border-radius: 8px;
      }

      #workspaces,
      #cpu,
      #memory,
      #disk,
      #pulseaudio,
      #network,
      #bluetooth,
      #clock {
        background: #${colors.base01};
        margin: 6px 6px;
        padding: 0px 12px;
        border-radius: 6px;
      }

      #cpu,
      #network {
        margin-right: 0px;
        padding-right: 6px;
        border-radius: 6px 0px 0px 6px;
      }

      #memory {
        margin-right: 0px;
        margin-left: 0px;
        border-radius: 0px;
      }

      #disk,
      #bluetooth {
        margin-left: 0px;
        padding-left: 6px;
        border-radius: 0px 6px 6px 0px;
      }
    '';
  };
}