{ ... }:
{
  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad = {
    naturalScrolling = true;
    scrollMethod = "edge";
  };
}