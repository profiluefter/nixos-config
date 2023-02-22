{ pkgs, config, ... }:
let
  waylandEnabled = false;
  gpuSandboxWorkaround = true;

  waylandFlags = if waylandEnabled then ["--enable-features=UseOzonePlatform" "--ozone-platform=wayland"] else [];
  gpuSandboxFlags = if gpuSandboxWorkaround then ["--disable-gpu-sandbox"] else [];

  discordArgs = waylandFlags ++ gpuSandboxFlags;
in
{
  home.packages = [ pkgs.discord ];

  xdg.desktopEntries.discord = {
    name = "Discord${if waylandEnabled then " (Wayland)" else ""}";
    genericName = "All-in-one cross-platform voice and text chat for gamers";
    exec = "discord ${builtins.concatStringsSep " " discordArgs}";
    terminal = false;
    categories = [ "Network" "InstantMessaging" ];
    icon = "discord";
    mimeType = [ "x-scheme-handler/discord" ];
  };

  # TODO: Clean up
  home.file.".config/autostart/Discord.desktop".source =
    config.lib.file.mkOutOfStoreSymlink "/home/fabian/.nix-profile/share/applications/discord.desktop";
}
