{
  self,
  inputs,
  withSystem,
  ...
}:
{
  flake.nixosConfigurations.robbi = withSystem "aarch64-linux" (
    { system, ... }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit system inputs;
      };
      modules = [
        self.nixosModules.robbi
        inputs.nixos-hardware.nixosModules.raspberry-pi-4
        {
          fileSystems = {
            "/boot/firmware" = {
              device = "/dev/disk/by-label/FIRMWARE";
              fsType = "vfat";
              options = [
                "nofail"
                "noauto"
              ];
            };
            "/" = {
              device = "/dev/disk/by-label/NIXOS_SD";
              fsType = "ext4";
            };
          };
        }
      ];
    }
  );

  flake.nixosModules.robbi =
    { ... }:
    {
      imports = [
        self.nixosModules.default
        self.nixosModules.users
      ];

      networking.hostName = "robbi";
    };
}
