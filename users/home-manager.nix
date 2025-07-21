{ config, inputs, ... }:
let
  topConfig = config;
in
{
  home-manager.useGlobalPkgs = true;

  home-manager.users.fabian =
    { pkgs, ... }:
    let
      lib2 = pkgs.callPackage ../lib { };
    in
    #  builtins.trace lib2
    {
      _module.args.lib2 = lib2;
      profi.workloads = topConfig.profi.workloads;

      imports = [
        inputs.plasma-manager.homeManagerModules.plasma-manager
        inputs.nix-index-database.homeModules.nix-index

        ../user-modules

        ./fabian/code.nix
      ];

      home.stateVersion = "23.05";
    };
}
