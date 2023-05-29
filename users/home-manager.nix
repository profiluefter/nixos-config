{ config, plasma-manager, nix-index-database, ... }:
let
  topConfig = config;
in
{
  home-manager.useGlobalPkgs = true;

  home-manager.users.fabian = { config, pkgs, ... }:
  let
    lib2 = pkgs.callPackage ../lib {};
  in
#  builtins.trace lib2
  {
    _module.args.lib2 = lib2;
    profi.workloads = topConfig.profi.workloads;

    imports = [
      plasma-manager.homeManagerModules.plasma-manager
      nix-index-database.hmModules.nix-index

      ../user-modules

      ./fabian/code.nix
    ];

#     home.stateVersion = "22.11";
    home.stateVersion = "22.05";
  };
}
