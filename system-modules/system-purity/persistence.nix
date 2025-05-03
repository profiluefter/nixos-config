{ lib, config, ... }:
with lib;
let
  cfg = config.profi.systemPurity;
in
{
  config = mkIf cfg.enable {
    environment.persistence."/data" = {
      hideMounts = true;

      files = [

      ];

      directories = [

      ];

      users.fabian = {
        files = [
          ".bash_history"
          ".config/plasma-org.kde.plasma.desktop-appletsrc" # plasma panel config
          ".lyx/session" # last opened file and shell-escape permission
          ".wakatime.cfg"
          ".wakatime-internal.cfg"
        ];

        directories = [
          ".config/JetBrains"
          ".config/discord"
          ".config/github-copilot"
          ".config/kdeconnect"
          ".config/keepassxc"
          ".config/unity3d"
          ".gnupg"
          ".java"
          ".local/share/applications"
          ".local/share/kscreen"
          ".local/share/kwalletd"
          ".mozilla"
          "Desktop"
          "Documents"
          "Music"
          "Pictures"
          "Videos"
        ];
      };
    };

    environment.persistence."/persist" = {
      hideMounts = true;

      files = [
        "/etc/machine-id"
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_ed25519_key.pub"
        "/etc/ssh/ssh_host_rsa_key"
        "/etc/ssh/ssh_host_rsa_key.pub"
      ];

      directories = [
        "/etc/NetworkManager/system-connections"
        "/root/.cache/mesa_shader_cache"
        "/var/lib/bluetooth"
        {
          directory = "/var/lib/syncthing";
          user = config.services.syncthing.user;
          group = config.services.syncthing.group;
          mode = "700";
        }
        "/var/lib/docker"
        "/var/lib/nixos"
        "/var/lib/sddm/.cache"
        "/var/lib/systemd/backlight"
      ];

      users.fabian = {
        files = [
          ".ssh/known_hosts"
        ];

        directories = [
          ".cache"
          ".cargo/registry"
          ".config/VirtualBox"
          ".gradle"
          ".local/share/baloo"
          ".local/share/direnv"
          ".local/share/JetBrains"
          ".local/share/nix"
          ".local/share/Steam"
          ".local/share/TelegramDesktop"
          ".local/state/wireplumber" # persist audio volumes
          ".oci"
          ".rustup"
          ".steam"
          ".tldrc"
          ".vagrant.d/boxes"
          "Downloads"
          "VirtualBox VMs"
        ];
      };
    };
  };
}
