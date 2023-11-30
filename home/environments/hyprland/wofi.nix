{ const, usrLib, ... }: {
  programs.wofi = {
    enable = true;
    settings = {
      show = "drun";
      width = 512;
      height = 360;
    };
    # style = with config.theme // usrLib.color; ''
    #   #window {
    #     border-radius = ${toString radius.md}px;
    #   }

    #   #input {
    #     background: ${hex (builtins.elemAt color.bg 0)}
    #   }

    #   #inner-box {
    #     background: ${hex (builtins.elemAt color.bg 1)}
    #   }
    # '';
  };
}