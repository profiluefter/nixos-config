{ config, peerix, lib, ... }:
{
  services.peerix = {
    enable = true;
    privateKeyFile = config.sops.secrets.peerixPrivateKeys.path;
    publicKeyFile = ./peerix-public;
    user = config.users.users.peerix.name;
  };

  # Default timeout is 50 which somehow is too low to frequently produce cache hits
  # see https://github.com/cid-chan/peerix/issues/21
  systemd.services.peerix.script = lib.mkForce ''
    exec ${config.services.peerix.package}/bin/peerix --timeout 1000
  '';

  users.users.peerix = {
    isSystemUser = true;
    group = "peerix";
  };
  users.groups.peerix = {};
}
