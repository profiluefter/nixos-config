{ pkgs, config, ... }:
{
  home.packages = [ pkgs.discord ];

  xdg.desktopEntries.discord = {
    name = "Discord (Wayland)";
    genericName = "All-in-one cross-platform voice and text chat for gamers";
    exec = "discord --enable-features=UseOzonePlatform --ozone-platform=wayland";
    terminal = false;
    categories = [ "Network" "InstantMessaging" ];
    icon = "discord";
    mimeType = [ "x-scheme-handler/discord" ];
  };

  # TODO: Clean up
  home.file.".config/autostart/Discord.desktop".source =
    config.lib.file.mkOutOfStoreSymlink "/home/fabian/.nix-profile/share/applications/discord.desktop";
}