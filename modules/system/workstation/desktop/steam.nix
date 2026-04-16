{ ... }:
{
  flake.nixosModules.gaming =
    { ... }:
    {
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
      };
    };
}
