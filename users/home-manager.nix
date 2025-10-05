{ config, inputs, ... }:
{
  home-manager.useGlobalPkgs = true;

  home-manager.users.fabian =
    { ... }:
    {
      imports = [
        inputs.plasma-manager.homeModules.plasma-manager
        inputs.nix-index-database.homeModules.nix-index

        ../user-modules

        # Import device-specific home configuration
        (../devices/${config.networking.hostName}/home.nix)

        ./fabian/code.nix
      ];

      home.stateVersion = "23.05";
    };
}
