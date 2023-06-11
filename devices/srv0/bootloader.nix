{ ... }:
{
  boot.loader.grub.enable = false;

  boot.loader.raspberryPi = {
    enable = true;
    version = 3;
    uboot.enable = true;
  };
}
