{ pkgs, ... }:
{
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.package = pkgs.unstable.virtualbox;
  users.extraGroups.vboxusers.members = [ "fabian" ];
  environment.systemPackages = [ pkgs.vagrant ];
}
