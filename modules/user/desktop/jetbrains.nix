{ ... }:
{
  flake.homeModules.coding =
    { pkgs, ... }:
    {
      home.packages = with pkgs.unstable.jetbrains; [
        idea-ultimate
        #rider
      ];
    };
}
