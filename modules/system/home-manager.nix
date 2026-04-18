{ ... }:
{
  flake.nixosModules.users =
    {
      inputs,
      ...
    }:
    {
      imports = [

        inputs.home-manager.nixosModules.home-manager
      ];

      home-manager.useGlobalPkgs = true;

      home-manager.users.fabian =
        { ... }:
        {
          #    TODO: import home-manager modules
          imports = [
            #        inputs.plasma-manager.homeModules.plasma-manager
            #        inputs.nix-index-database.homeModules.nix-index
            #
            #        ../user-modules
            #
            #        # Import device-specific home configuration
            #        (../devices/${config.networking.hostName}/home.nix)
          ];

          home.stateVersion = "23.05";
        };
    };
}
