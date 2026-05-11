### Context7 library IDs

Relevant to this repository's current `flake-parts` / NixOS-module migration work:

- `flake-parts` docs: `/websites/flake_parts`
  - Best general-reference target for `withSystem`, `moduleWithSystem`, `perSystem`, published modules, and `nixosConfigurations` patterns.
- `flake-parts` repo: `/hercules-ci/flake-parts`
  - Useful as a secondary source when repo examples are more helpful than the rendered docs.
- `nixpkgs`: `/nixos/nixpkgs`
  - Use for `nixosSystem`, overlay shape, package-set conventions, and NixOS module behavior.
- `nixpkgs` reference manual: `/websites/nixos_manual_nixpkgs`
  - Good fallback when you want manual-style prose instead of repository examples.
- `import-tree`: `/vic/import-tree`
  - Relevant because `flake.nix` imports `modules/` via `inputs.import-tree ./modules`.

### Notes for this repo

- In `flake-parts`, values like `inputs`, `self`, `withSystem`, `moduleWithSystem`, `inputs'`, and `self'` belong to the flake-parts/module scope, not automatically to inner NixOS module argument sets.
- For reusable `flake.nixosModules.*`, prefer capturing flake-level values from the outer scope or use `moduleWithSystem` when per-system data is required.
- For `flake.nixosConfigurations.*`, `withSystem` is the documented way to enter a system scope and then call `inputs.nixpkgs.lib.nixosSystem`.
- `specialArgs` can expose values to NixOS modules, including for `imports`, but flake-parts docs recommend not relying on that for published/reusable modules when flake scope can be used directly.
- `nixpkgs` overlays should have the plain shape `final: prev: { ... }`; they are not called with a flake-parts-style `{ system, ... }` argument set.
