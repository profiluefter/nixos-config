{ ... }:
{
  # Common user modules that should always be imported
  imports = [
    ./vim
    ./nix-index.nix
    ./nixpkgs.nix
    ./scripts.nix
    ./shell.nix
  ];
}
