{
  self,
  inputs,
  withSystem,
  ...
}:
{
  flake.homeModules.fabian-ws =
    { ... }:
    {
      imports = [
        self.homeModules.default
      ];
    };

  flake.nixosConfigurations.fabian-ws = withSystem "x86_64-linux" (
    { system, ... }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit system inputs;
      };
      modules = [
        self.nixosModules.fabian-ws
      ];
    }
  );

  flake.nixosModules.fabian-ws =
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

      networking.hostName = "fabian-ws";

      home-manager.users.fabian = self.homeModules.fabian-ws;
    };
}
