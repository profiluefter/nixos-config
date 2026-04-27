{ ... }:
{
  flake.homeModules.plasma =
    { ... }:
    {
      services.kdeconnect = {
        enable = true;
        indicator = true;
      };
    };
}
