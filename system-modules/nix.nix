{ nixpkgs, ... }:
{
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];

    registry.nixpkgs.flake = nixpkgs;

    nixPath = [
      "nixpkgs=${nixpkgs}"
      "/nix/var/nix/profiles/per-user/root/channels"
    ];
  };
}
