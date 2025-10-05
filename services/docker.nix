{ ... }:
{
  virtualisation.docker.enable = true;
  # TODO: pull images as part of system build instead of persisting them
  # https://nixos.org/manual/nixpkgs/stable/#ssec-pkgs-dockerTools-fetchFromRegistry
}
