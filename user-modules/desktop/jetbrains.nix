{ pkgs, lib2, config, ... }:
{
  home.packages = with pkgs.unstable.jetbrains; lib2.mkIfWorkload config "coding" [
    idea-ultimate
    rider
  ];
}
