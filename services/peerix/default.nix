{ config, peerix, ... }:
{
  services.peerix = {
    enable = true;
    privateKeyFile = config.sops.secrets.peerixPrivateKeys.path;
    publicKeyFile = ./peerix-public;
    user = config.users.users.peerix.name;
  };

  users.users.peerix = {
    isSystemUser = true;
    group = "peerix";
  };
  users.groups.peerix = {};
}
