{ pkgs, lib, config, ... }:
let cfg = config.modules.gpu-amd;
in {
  options.modules.gpu-amd = {
    enable = lib.mkEnableOption "gpu-amd";
  };

  config = lib.mkIf cfg.enable {
    boot.initrd.kernelModules = [ "amdgpu" ];
    services.xserver.videoDrivers = [ "amdgpu" "modesetting" ];

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };

  };
}
