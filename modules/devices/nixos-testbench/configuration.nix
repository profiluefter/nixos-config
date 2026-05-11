{ self, inputs, ... }:
{
  flake.nixosConfigurations.nixos-testbench = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.nixosModules.nixos-testbench
    ];
  };

  flake.nixosModules.nixos-testbench =
    { ... }:
    {
      imports = [
        self.nixosModules.default
        self.nixosModules.users
        self.nixosModules.secrets
        self.nixosModules.workstation
        self.nixosModules.containers

        # TODO: move to individual device configs
        self.nixosModules.gaming
        self.nixosModules.syncthing
        self.nixosModules.virtualbox
        self.nixosModules.plasma

        inputs.impermanence.nixosModule
        inputs.disko.nixosModules.disko
      ];

      users.users.test = {
        isNormalUser = true;
        description = "Test user for nixos-testbench";
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
        initialPassword = "test";
      };
    };
}
