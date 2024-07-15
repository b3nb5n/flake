{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    eww
    jq
    bc
  ];

  xdg.configFile = {
    "eww/eww.scss".text = lib.strings.concatLines [
      ''
        $bg: #1f2335;
        $fg: #c0caf5;
        $interactive: #292e42;
        $hover: #414868;
        $active: #7dcfff;
      ''
      (builtins.readFile ./eww.scss)
    ];
    "eww/eww.yuck".text = lib.strings.concatLines (
      (builtins.map
        (path:
          if (lib.strings.hasSuffix ".yuck" path)
          then ''
            (include "${path}")''
          else ""
        )
        (lib.filesystem.listFilesRecursive ./widgets)
      ) ++ [
        # yuck
        ''
          (deflisten listener-workspaces
            :initial "[]"
            "${pkgs.hyprland-workspaces}/bin/hyprland-workspaces ALL"
          )

          (deflisten listener-wifi
            :initial "{\"powered\":false,\"connected\":false}"
            "${./scripts/listener/wifi.sh}"
          )

          (deflisten listener-bluetooth
            :initial "{\"powered\":false,\"connected\":false}"
            "${./scripts/listener/bluetooth.sh}" 
          )

          (defpoll uptime
            :interval "30s"
            :initial "0s"
            "${./scripts/getter/uptime.sh}"
          )

          (defvar set-workspace
            "${pkgs.hyprland}/bin/hyprctl dispatch workspace name:"
          )

          (defvar create-workspace
            "${./scripts/action/create-workspace.sh}"
          )
        ''
      ]
    );
  } //
  (builtins.listToAttrs
    (builtins.concatMap
      (path:
        let
          baseName = "eww/icons/workspace/${lib.removeSuffix ".svg" (baseNameOf path)}";
        in
        [
          {
            name = "${baseName}-active.svg";
            value.text = builtins.replaceStrings
              [ "#000000" ]
              [ "#1f2335" ]
              (builtins.readFile path);
          }
          {
            name = "${baseName}-inactive.svg";
            value.text = builtins.replaceStrings
              [ "#000000" ]
              [ "#c0caf5" ]
              (builtins.readFile path);
          }
        ])
      (lib.filesystem.listFilesRecursive ./icons/workspace)
    )
  ) //
  (builtins.listToAttrs
    (builtins.concatMap
      (path:
        let
          baseName = "eww/icons/status/${lib.removeSuffix ".svg" (baseNameOf path)}";
        in
        [
          {
            name = "${baseName}-active.svg";
            value.text = builtins.replaceStrings
              [ "#000000" "#FF0000" ]
              [ "#c0caf5" "#1f2335" ]
              (builtins.readFile path);
          }
          {
            name = "${baseName}-inactive.svg";
            value.text = builtins.replaceStrings
              [ "#000000" ]
              [ "#c0caf5" ]
              (builtins.readFile path);
          }
          {
            name = "${baseName}-disabled.svg";
            value.text = builtins.replaceStrings
              [ "#000000" ]
              [ "#1f2335" ]
              (builtins.readFile path);
          }
        ]
      )
      (lib.filesystem.listFilesRecursive ./icons/status)
    )
  ) //
  (builtins.listToAttrs
    (builtins.concatMap
      (path: [
        {
          name = "eww/icons/action/${baseNameOf path}";
          value.text = builtins.replaceStrings
            [ "#000000" ]
            [ "#c0caf5" ]
            (builtins.readFile path);
        }
      ])
      (lib.filesystem.listFilesRecursive ./icons/action)
    )
  );

  wayland.windowManager.hyprland.settings.exec-once =
    let ewwBin = "${pkgs.eww}/bin/eww";
    in [ "${ewwBin} daemon && ${ewwBin} open status-bar" ];
}
