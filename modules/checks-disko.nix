{ self, lib, ... }:
{
  # For every device with a `flake.diskoConfigurations.<name>` entry, expose
  # `checks.<system>.disko-<name>` that builds the device's `diskoScript`.
  # This forces full evaluation of the disko config and validates the generated
  # partitioning script with shellcheck (via disko's `writeCheckedBash`), so
  # `nix flake check` catches disko regressions standalone - without having to
  # build the whole NixOS system.
  perSystem =
    { system, ... }:
    {
      checks =
        lib.mapAttrs'
          (name: _: {
            name = "disko-${name}";
            value = self.nixosConfigurations.${name}.config.system.build.diskoScript;
          })
          (
            lib.filterAttrs (
              name: _:
              (self.nixosConfigurations ? ${name})
              && self.nixosConfigurations.${name}.pkgs.stdenv.hostPlatform.system == system
            ) self.diskoConfigurations
          );
    };
}
