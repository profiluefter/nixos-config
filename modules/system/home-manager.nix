{ inputs, ... }:
{
  flake.nixosModules.users =
    { ... }:
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
      ];

      home-manager.useGlobalPkgs = true;
    };

  flake.homeModules.default =
    { ... }:
    {
      imports = [
        inputs.plasma-manager.homeModules.plasma-manager
        inputs.nix-index-database.homeModules.nix-index
      ];
    };
}
