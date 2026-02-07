{ lib, config, ... }:
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

    environment.variables.VK_ICD_FILENAMES =
      "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json:/run/opengl-driver-32/share/vulkan/icd.d/radeon_icd.i686.json";
  };
}
