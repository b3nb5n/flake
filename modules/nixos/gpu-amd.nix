{ pkgs, config, ... }: {
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" "modesetting" ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [ amdvlk ];
    };
  };

  environment = {
    systemPackages = with pkgs; [ nvtopPackages.amd ];
    variables.VK_ICD_FILENAMES =
      "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json:/run/opengl-driver-32/share/vulkan/icd.d/radeon_icd.i686.json";
    extraInit =
      "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${config.environment.variables.VK_ICD_FILENAMES}";
  };
}
