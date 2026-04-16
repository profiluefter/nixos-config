{ inputs, self, ... }:
{
  perSystem =
    { pkgs, ... }:
    let
      treefmtConfig =
        { ... }:
        {
          projectRootFile = "flake.nix";
          settings.global.excludes = [
          ];

          programs.nixfmt.enable = true;
          programs.deadnix.enable = true;

          programs.mdformat.enable = true;

          programs.shellcheck.enable = true;
          programs.shfmt.enable = true;

          programs.yamlfmt.enable = true;
          programs.yamlfmt.settings = {
            formatter = {
              "retain_line_breaks_single" = true;
            };
          };
        };
      treefmtEval = inputs.treefmt-nix.lib.evalModule pkgs treefmtConfig;
    in
    {
      checks.formatting = treefmtEval.config.build.check self;
      formatter = treefmtEval.config.build.wrapper;
    };
}
