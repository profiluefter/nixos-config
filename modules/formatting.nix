{ inputs, self, ... }:
{
  perSystem =
    { pkgs, ... }:
    let
      treefmtEval = inputs.treefmt-nix.lib.evalModule pkgs ../treefmt.nix;
    in
    {
      checks.formatting = treefmtEval.config.build.check self;
      formatter = treefmtEval.config.build.wrapper;
    };
}
