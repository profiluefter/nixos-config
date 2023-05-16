{ pkgs, config, lib2, ... }:
{
  virtualisation.virtualbox.host.enable = lib2.hasWorkload config "desktop";
  virtualisation.virtualbox.host.package = pkgs.unstable.virtualbox;
  users.extraGroups.vboxusers.members = lib2.mkIfWorkload config "desktop" [ "fabian" ];
}
