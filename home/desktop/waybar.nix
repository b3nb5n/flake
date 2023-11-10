{ pkgs, ... }: {
  programs.waybar = {
    enable = true;
    # style = ''
    #   * {
    #     border: none;
    #     border-radius: 0;
    #     font-family: sans-serif;
    #     font-size: 16px;
    #     min-height: 0;
    #   }

    #   window#waybar {
    #     margin: 12px;
    #     marginBottom: 8px;
    #     background: rgba(43, 48, 59, 0.5);
    #     color: white;
    #   }

    #   tooltip {
    #     background: rgba(43, 48, 59, 0.5);
    #     border: 1px solid rgba(100, 114, 125, 0.5);
    #   }

    #   tooltip label {
    #     color: white;
    #   }

    #   #workspaces button {
    #     padding: 0 5px;
    #     background: transparent;
    #     color: white;
    #     border-bottom: 3px solid transparent;
    #   }

    #   #workspaces button.focused {
    #     background: #64727D;
    #     border-bottom: 3px solid white;
    #   }

    #   #mode {
    #     background: #64727D;
    #     border-bottom: 3px solid white;
    #   }

    #   #clock {
    #     background-color: #64727D;
    #   }
    # '';
  };

  home.file.waybarConfig = {
    enable = false;
    target = ".config/waybar/config.json";
    text = ''
      {
        "layer": "top",
        "position": "top",
        "height": 36,
        "spacing": 4,

        "modules-left": [],
        "modules-center": [],
        // "pulseaudio", "network", "cpu", "memory", "temperature", 
        "modules-right": ["clock"],

        "pulseaudio": {
          "format": "{volume}% {icon} {format_source}",
          "format-bluetooth": "{volume}% {icon} {format_source}",
          "format-bluetooth-muted": " {icon} {format_source}",
          "format-muted": " {format_source}",
          "format-source": "{volume}% ",
          "format-source-muted": "",
          "format-icons": {
            "headphone": "",
            "hands-free": "",
            "headset": "",
            "phone": "",
            "portable": "",
            "car": "",
            "default": ["", "", ""]
          },
          "on-click": "pavucontrol"
        },
        "network": {
          "format-wifi": "{essid} ({signalStrength}%) ",
          "format-ethernet": "{ipaddr}/{cidr} ",
          "tooltip-format": "{ifname} via {gwaddr} ",
          "format-linked": "{ifname} (No IP) ",
          "format-disconnected": "Disconnected ⚠",
          "format-alt": "{ifname}: {ipaddr}/{cidr}"
        },
        "temperature": {
          // "thermal-zone": 2,
          // "hwmon-path": "/sys/class/hwmon/hwmon2/temp1_input",
          "critical-threshold": 80,
          // "format-critical": "{temperatureC}°C {icon}",
          "format": "{temperatureC}°C {icon}",
          "format-icons": ["", "", ""]
        },
        "memory": {
          "format": "{}% "
        },
        "cpu": {
          "format": "{usage}% ",
          "tooltip": false
        },
        "clock": {
          "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
          "format-alt": "{:%Y-%m-%d}"
        },
      }
    '';
  };

  # home.file.waybarStyle = {
  #   target = ".config/waybar/style.css";
  #   text = 
  # };
}