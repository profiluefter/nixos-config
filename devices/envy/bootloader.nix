{ ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.systemd-boot.extraEntries."arch.conf" = ''
    title   Arch btw
    linux   /vmlinuz-linux-zen
    initrd  /intel-ucode.img
    initrd  /initramfs-linux-zen.img
    options root="PARTLABEL=disk-ssd-btrfs" rootflags="subvol=arch-os" rw quiet splash log_level=3 udev.log_level=3
  '';
}
