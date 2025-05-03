{ config, lib2, ... }:
{
  services.kdeconnect = lib2.mkIfWorkload config "desktop" {
    enable = true;
    indicator = true;
  };
}
