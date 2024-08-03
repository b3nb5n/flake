{ pkgs, config, ... }: {
  boot = {
    initrd.kernelModules = [ "nvidia" ];
    kernelParams = [ "nvidia-drm.modset=1" "nvidia-drm.fbdev=1" ];
    extraModulePackages = [ config.hardware.nvidia.package ];
  };

  hardware = {
    graphics.enable = true;
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      open = false;
      nvidiaSettings = true;
      forceFullCompositionPipeline = true;
    };
  };

  nixpkgs.config.nvidia.acceptLicense = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  environment.systemPackages = with pkgs; [ nvtopPackages.nvidia ];
}
