{ lib, inputs, config, ... }:
{
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "fabian" ];
      auto-optimise-store = true;
    };

    # stolen from https://github.com/Misterio77/nix-starter-configs/blob/fe21fa16704972126a9660622b8464bd215c7894/minimal/nixos/configuration.nix#L44-L50

    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
  };
}
