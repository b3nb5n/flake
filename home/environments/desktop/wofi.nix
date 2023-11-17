{ const, utils, ... }: {
  programs.wofi = {
    enable = true;
    settings = {
      show = "drun";
      width = 512;
      height = 360;
    };
    style = with const.theme.colors // utils.theme; ''
      #window {
        border-radius = 8px;
      }

      #input {
        background: #${hex base01}
      }

      #inner-box {
        background: ${hex base02}
      }
    '';
  };
}