{ config, ... }:
let
  dataDir = config.services.syncthing.dataDir;
in
{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;

    user = "fabian";
    group = "users";

    dataDir = "/data/sync";
    configDir = "/var/lib/syncthing";

    overrideDevices = true;
    overrideFolders = true;

    # would've been nice to also put these IDs into a sops secret
    # however this isn't easily possible as sops secrets are not available at evaluation time
    # but this isn't a security risk since syncthing IDs do not have to be secret
    # https://docs.syncthing.net/users/faq.html#should-i-keep-my-device-ids-secret

    settings = {
      # TODO: don't share everything with everyone, instead clean this section up and specify individual devices
      folders =
        let
          all-devices = [
            "qnap"
            "fabian-ws"
            "fabian-ws nix-os"
            "Pixel 2 XL"
            "Envy Arch"
            "Envy NixOS"
            "acsc-laptop"
          ];
          makeFolder = id: name: {
            inherit id;
            path = dataDir + "/" + name;
            devices = all-devices;
          };
        in
        {
          "scans" = makeFolder "mt7nr-50dl7" "scans";
          "passwords" = makeFolder "yhe6x-62vk3" "passwords";
          "school" = makeFolder "73wqj-syzlb" "school";
          "school-pos2020-21" = makeFolder "xodip-oqysp" "school-pos2020-21";
          "school-pos2021-22" = makeFolder "jae5j-cxume" "school-pos2021-22";
          "school22-23" = makeFolder "zshij-ca9kc" "school22-23";
          "code-cpp" = makeFolder "yhwae-wg5ng" "code-cpp";
          "code-cs" = makeFolder "4nzax-i5nof" "code-cs";
          "code-go" = makeFolder "apgi2-q3rth" "code-go";
          "code-java" = makeFolder "c7phb-gcknu" "code-java";
          "code-js" = makeFolder "2yjkt-rzayh" "code-js";
          "code-misc" = makeFolder "2vrxg-ysjxm" "code-misc";
          "code-php" = makeFolder "rika3-wehhh" "code-php";
          "code-python" = makeFolder "5pi5y-k5znl" "code-python";
          "code-rust" = makeFolder "x9vke-w6nos" "code-rust";
        };

      devices = {
        "qnap" = {
          addresses = [
            "tcp://10.0.0.22:22000"
            "dynamic"
          ];
          id = "WLHA6GB-DTKV73G-VHL5BY7-TJREZ66-3CFDE5F-SYS5T3R-PYY4QL6-XM3EZAC";
        };

        "fabian-ws" = {
          addresses = [
            "tcp://10.0.0.25:22000"
            "dynamic"
          ];
          id = "5LHDNQQ-D7IIIAV-A7PVO3R-MD5YLEJ-RFHSSZN-22IR3SO-D5DTR74-LOSALQ5";
        };
        "fabian-ws nix-os" = {
          addresses = [
            "tcp://10.0.0.25:22000"
            "dynamic"
          ];
          id = "XGJU3CG-T2MC2LL-ATMXTNQ-64VBLXP-J63CW7Q-JOT33HW-M7BCCBP-32EZEAD";
        };

        "Pixel 2 XL" = {
          addresses = [
            "tcp://10.0.0.50:22000"
            "dynamic"
          ];
          id = "ZLMR6UX-DLT45PG-E5OI2HG-76DBBBO-PRKU247-3TKECJ2-LBHB735-OG7BLQP";
        };

        "Envy Arch" = {
          addresses = [
            "tcp://10.0.0.26:22000"
            "dynamic"
          ];
          id = "3UZLIEL-4DG7DWP-EM5E5R3-YUNQWN3-NNSRJOK-VCL5AER-KVJK2PL-AJR3EQM";
        };
        "Envy NixOS" = {
          addresses = [
            "tcp://10.0.0.26:22000"
            "dynamic"
          ];
          id = "YV4BSTD-EFKXRTV-K7FT6UF-RZ5DUA4-ROGPWS4-TYWJWKM-DXPECTY-ZX6JFA4";
        };

        "acsc-laptop" = {
          id = "DKWDRZL-QWL6S2U-7U7HQEK-LBSWOJS-JTLDFHN-7KVVT2V-HYSDNSY-QTXUHQR";
        };
      };
    };
  };
}
