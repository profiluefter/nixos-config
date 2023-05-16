{ pkgs, lib2, config, ... }:
{
  programs.java.enable = lib2.hasWorkload config "coding";

  home.packages = with pkgs; lib2.mkIfWorkload config "coding" [
    nodejs
    yarn

    pkgs.unstable.supabase-cli
  ];
}
