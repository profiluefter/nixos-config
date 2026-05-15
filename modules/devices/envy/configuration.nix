{
  self,
  inputs,
  withSystem,
  ...
}:
{
  flake.homeModules.envy =
    { ... }:
    {
      imports = [
        self.homeModules.default
      ];
    };

  flake.nixosConfigurations.envy = withSystem "x86_64-linux" (
    { system, ... }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit system inputs;
      };
      modules = [
        self.nixosModules.envy
      ];
    }
  );

  flake.nixosModules.envy =
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
      ];

      networking.hostName = "envy";

      home-manager.users.fabian = self.homeModules.envy;
    };
}
