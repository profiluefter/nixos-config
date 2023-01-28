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

    folders =
      let
        all-devices = ["srv0" "fabian-ws" "fabian-ws pop-os" "Pixel 2 XL" "Envy Arch" "Envy Windows"];
        makeFolder = id: name:
          {
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
      "srv0" = {
        addresses = [ "tcp://10.0.0.10:22000" "dynamic" ];
        id = "UUZVBRP-6HZFIXJ-R63ZECA-KPNNSP6-NEM77RE-YC6RMVM-OTHOK7S-FU6OVQJ";
      };

      "fabian-ws" = {
        addresses = [ "tcp://10.0.0.25:22000" "dynamic" ];
        id = "5LHDNQQ-D7IIIAV-A7PVO3R-MD5YLEJ-RFHSSZN-22IR3SO-D5DTR74-LOSALQ5";
      };
      "fabian-ws pop-os" = {
        addresses = [ "tcp://10.0.0.25:22000" "dynamic" ];
        id = "C254SXY-ROS5BVQ-74K6V5E-HDPTTBD-VLTYEEU-DD4R7IX-45TB6IQ-CO5RMQQ";
      };
      # TODO: fabian-ws nix-os

      "Pixel 2 XL" = { 
        addresses = [ "tcp://10.0.0.50:22000" "dynamic" ];
        id = "LO4Z5IJ-RV67V4Z-5MQDEIO-IHXZLD3-ZFND3DT-OPGQRJD-JRTA4WU-G75GGQ4"; 
      };
      
      "Envy Arch" = { id = "3UZLIEL-4DG7DWP-EM5E5R3-YUNQWN3-NNSRJOK-VCL5AER-KVJK2PL-AJR3EQM"; };
      "Envy Windows" = { id = "KAY3C53-ZIKO374-QRKPRR7-4CZZQWU-M5HS6CR-M2BRFO5-CRXPJDP-HUHGBAQ"; };
      # TODO: envy nixos
    };
  };
}
