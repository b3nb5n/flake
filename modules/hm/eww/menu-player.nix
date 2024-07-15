{ pkgs, ... }: {
  xdg.configFile = {
    ewwYuck.text = /* yuck */ ''
      (defwindow menu-player
        :monitor 0
        :stacking "fg"
        :exclusive false
        :geometry (geometry
          :anchor "top left"
          :x "12px"
          :y "12px"
          :height "512px" 
          :width "360px"
        )

        (menu-player)
      )
    '';
    ewwScss.text = /* scss */ '''';
  };
}
