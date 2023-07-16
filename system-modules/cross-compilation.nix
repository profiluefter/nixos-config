{ config, lib2, ... }:
{
  boot.binfmt.emulatedSystems = lib2.mkIfWorkload config "cross-compile" [ "aarch64-linux" ];
}
