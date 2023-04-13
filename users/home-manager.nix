{ config, lib2, plasma-manager, ... }:
let
  topConfig = config;
in
{
  home-manager.useGlobalPkgs = true;

  home-manager.users.fabian = { config, pkgs, ... }:
  {
    _module.args.lib2 = lib2;
    profi.workloads = topConfig.profi.workloads ++ [
      "school"
      "android"
    ];

    imports = [
      plasma-manager.homeManagerModules.plasma-manager

      ../user-modules

      ./fabian/code.nix
      ./fabian/discord.nix
      ./fabian/gpg.nix
      ./fabian/java.nix
      ./fabian/jetbrains.nix
      ./fabian/kdeconnect.nix
      ./fabian/keepassxc.nix
      ./fabian/konsole.nix
      ./fabian/latex.nix
      ./fabian/nixpkgs.nix
      ./fabian/node.nix
      ./fabian/plasma.nix
      ./fabian/school.nix
      ./fabian/shell.nix
      ./fabian/supabase.nix
    ];

    home.packages = with pkgs; [
      firefox-wayland

      xournalpp
      libreoffice

      kate
      vlc

      virt-viewer
    ];

#     home.stateVersion = "22.11";
    home.stateVersion = "22.05";
  };
}
