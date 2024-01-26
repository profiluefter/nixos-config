{ ... }:
{
  networking.networkmanager.ensureProfiles.profiles = {
    "vpn.profiluefter.me" = {
      connection = {
        id = "vpn.profiluefter.me";
        type = "vpn";
      };
      vpn = {
        service-type = "org.freedesktop.NetworkManager.openvpn";
        connection-type = "tls";
        dev = "tun";
        remote = "vpn.profiluefter.me:993:tcp";

        remote-cert-tls = "server";
        cert-pass-flags = "0";

        ca = "/run/secrets/vpn-ca";
        cert = "/run/secrets/vpn-cert";
        key = "/run/secrets/vpn-key";
        tls-crypt-v2 = "/run/secrets/vpn-tls-crypt-v2";
      };
      ipv4 = {
        method = "auto";
        never-default = "true";
        may-fail = "false";

        dns = "10.0.0.1;";
        route1 = "10.0.0.0/24,10.0.0.1,0";
      };
      ipv6 = {
        method = "auto";
        addr-gen-mode = "stable-privacy";
      };
    };
  };
}
