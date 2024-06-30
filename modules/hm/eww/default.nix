{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    eww
    jq
    bc
  ];

  xdg.configFile = {
    "eww/eww.yuck".text = builtins.readFile ./eww.yuck;
    "eww/eww.scss".text = builtins.readFile ./eww.scss;
    "eww/components".source = ./components;
    "eww/scripts".source = ./scripts;
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
    in [
      "${ewwBin} daemon && ${ewwBin} open status-bar"
    ];
}
