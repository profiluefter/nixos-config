{ config, plasma-manager, ... }:
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
    profi.workloads = topConfig.profi.workloads ++ [
      "school"
      "android"
    ];

    imports = [
      plasma-manager.homeManagerModules.plasma-manager

      ../user-modules

      ./fabian/code.nix
    ];

    home.packages = with pkgs; [
      xournalpp
      virt-viewer
    ];

#     home.stateVersion = "22.11";
    home.stateVersion = "22.05";
  };
}
