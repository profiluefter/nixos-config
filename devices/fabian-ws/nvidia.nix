{ ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia.modesetting.enable = true;
  # Should make graphic glitches after suspending better
  # but actually makes it worse currently, so it's disabled for now
  # tracking issue: https://github.com/NixOS/nixpkgs/issues/254614
  hardware.nvidia.powerManagement.enable = false;
}
