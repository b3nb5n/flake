{ pkgs, config, ... }: {
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    extraPackages = [ pkgs.amdvlk ];
  };

  environment = {
    variables.VK_ICD_FILENAMES =
      "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json:/run/opengl-driver-32/share/vulkan/icd.d/radeon_icd.i686.json";
    extraInit =
      "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${config.environment.variables.VK_ICD_FILENAMES}";
  };
}
