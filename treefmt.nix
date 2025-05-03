{ ... }:
{
  projectRootFile = "flake.nix";
  settings.global.excludes = [
    "services/peerix/peerix-public" # plain text file
  ];

  programs.nixfmt.enable = true;
  programs.deadnix.enable = true;

  programs.mdformat.enable = true;

  programs.shellcheck.enable = true;

  programs.yamlfmt.enable = true;
  programs.yamlfmt.settings = {
    formatter = {
      "retain_line_breaks_single" = true;
    };
  };
}
