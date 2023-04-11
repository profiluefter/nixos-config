{ ... }:
{
  home-manager.useGlobalPkgs = true;

  home-manager.users.fabian = { config, pkgs, ... }:
  {
    imports = [
      ./fabian/android.nix
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
      ./fabian/telegram
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
