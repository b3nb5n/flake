{ pkgs, ... }: {
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  
  hardware.opengl = {
    enable = true;
    driSupport = true;
    extraPackages = [ pkgs.amdvlk ];
  };
}