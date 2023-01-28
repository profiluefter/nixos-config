{ pkgs, ... }:
{
  home.packages = [
    pkgs.unstable.supabase-cli
  ];
}
