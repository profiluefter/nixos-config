{ lib2, config, ... }:
{
  programs.steam = lib2.mkIfWorkload config "gaming" {
    enable = true;
    remotePlay.openFirewall = true;
  };
}
