{ inputs, self, ... }:
{
  flake.overlays.unstable =
    { system, ... }:
    _final: _prev: {
      unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
        config.android_sdk.accept_license = true;
      };
    };
  flake.nixosModules.default =
    { ... }:
    {
      system.configurationRevision = self.rev or "dirty";

      nixpkgs.overlays = [ self.overlays.unstable ];

      nixpkgs.config.allowUnfree = true;
    };
  flake.homeModules.default =
    { ... }:
    {
      home.file.".config/nixpkgs/config.nix".text = "{ allowUnfree = true; }";
    };
}
