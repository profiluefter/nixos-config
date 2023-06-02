{ pkgs, ... }:
{
  environment.sessionVariables."NIXOS_CONFIG" = "/data/sync/code-misc/nixos-config/configuration.nix";

  # REMEMBER: https://github.com/thiagokokada/nix-alien

  # FIXME: xournalpp workaround
  environment.systemPackages = [
    pkgs.gnome.adwaita-icon-theme
    pkgs.shared-mime-info
  ];
  environment.pathsToLink = [
    "/share/icons"
    "/share/mime"
  ];

  imports = [
    ./system-packages.nix
    ./locales.nix

    ./system-modules

    ./services/docker.nix
    ./services/firewall.nix
    ./services/networking.nix
    ./services/openssh.nix
    ./services/peerix
    ./services/pipewire.nix
    ./services/syncthing.nix

    ./users/profiles.nix
    ./users/home-manager.nix

    ./sops.nix
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
