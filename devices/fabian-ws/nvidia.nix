{ ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia.modesetting.enable = true;
  # Should make graphic glitches after suspending better
  # but actually makes it worse currently
  hardware.nvidia.powerManagement.enable = true;
}
