{ pkgs, lib2, config, ... }:
{
  home.packages = with pkgs; lib2.mkIfWorkload config "school" [
    geogebra
  ];

  programs.bash.shellAliases = lib2.mkIfWorkload config "school" {
    heimo = "curl -s -d \"auth_user=$(cat /run/secrets/schoolUser)\" -d \"auth_pass=$(cat /run/secrets/schoolPassword)\" -d 'accept=Anmelden' http://10.10.0.251:8002/index.php?zone=cp_htl";
  };
}
