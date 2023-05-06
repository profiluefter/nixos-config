{ pkgs, config, lib2, ... }:
let
  waylandEnabled = false;
  gpuSandboxWorkaround = true;

  waylandFlags = if waylandEnabled then ["--enable-features=UseOzonePlatform" "--ozone-platform=wayland"] else [];
  gpuSandboxFlags = if gpuSandboxWorkaround then ["--disable-gpu-sandbox"] else [];

  discordArgs = waylandFlags ++ gpuSandboxFlags;
in
with lib2;
{
  home.packages = mkIfWorkload "desktop" [ pkgs.discord ];

  xdg.desktopEntries.discord = mkIfWorkload "desktop" {
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
    mkIfWorkload "desktop"
    config.lib.file.mkOutOfStoreSymlink "/home/fabian/.nix-profile/share/applications/discord.desktop";
}