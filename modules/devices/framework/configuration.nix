{
  self,
  inputs,
  withSystem,
  ...
}:
{
  flake.homeModules.framework =
    { ... }:
    {
      imports = [
        self.homeModules.default
      ];
    };

  flake.nixosConfigurations.framework = withSystem "x86_64-linux" (
    { system, ... }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit system inputs;
      };
      modules = [
        self.nixosModules.framework
      ];
    }
  );

  flake.nixosModules.framework =
    { ... }:
    {
      imports = [
        self.nixosModules.default
        self.nixosModules.users
        self.nixosModules.secrets
        self.nixosModules.workstation
        self.nixosModules.containers

        self.nixosModules.gaming
        self.nixosModules.syncthing
        self.nixosModules.virtualbox
        self.nixosModules.plasma

        inputs.impermanence.nixosModule
        inputs.disko.nixosModules.disko

        inputs.nixos-hardware.nixosModules.framework-13th-gen-intel
      ];

      networking.hostName = "framework";

      home-manager.users.fabian = self.homeModules.framework;

      fileSystems."/data".neededForBoot = true;
      fileSystems."/persist".neededForBoot = true;
      fileSystems."/var/log".neededForBoot = true;

      disko = {
        enableConfig = true;
        checkScripts = true;
      };
    };
}
