{ ... }: {
  programs.wofi = {
    enable = true;
    settings = {
      show = "drun";
      width = 512;
      height = 360;
    };
  };
}