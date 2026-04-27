{ ... }:
{
  flake.homeModules.desktop-common =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.unstable.discord ];

      # TODO: the nixos package now supports wayland natively, maybe has to be configured
      /*
        xdg.desktopEntries = {
          discord = {
            name = "Discord${if waylandEnabled then " (Wayland)" else ""}";
            genericName = "All-in-one cross-platform voice and text chat for gamers";
            exec = "discord ${builtins.concatStringsSep " " discordArgs}";
            terminal = false;
            categories = [
              "Network"
              "InstantMessaging"
            ];
            icon = "discord";
            mimeType = [ "x-scheme-handler/discord" ];
          };
        };

        # TODO: Clean up
        home.file = {
          ".config/autostart/Discord.desktop".source = (
            config.lib.file.mkOutOfStoreSymlink "/home/fabian/.nix-profile/share/applications/discord.desktop"
          );
        };
      */
    };
}
