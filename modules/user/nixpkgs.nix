{ ... }:
{
  flake.homeModules.default =
    { ... }:
    {
      home.file.".config/nixpkgs/config.nix".text = "{ allowUnfree = true; }";
    };
}
