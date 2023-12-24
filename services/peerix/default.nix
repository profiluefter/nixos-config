{ config, inputs, system, lib, ... }:
lib.mkIf (system == "x86_64-linux") # peerix doesn't compile on aarch64
{
  services.peerix = {
    enable = true;
    package = inputs.peerix.packages.${system}.peerix;
    privateKeyFile = config.sops.secrets.peerixPrivateKeys.path;
    publicKey = builtins.replaceStrings [ "\r" "\n" ] [ "" "" ] (builtins.readFile ./peerix-public);
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
  users.groups.peerix = { };
}
