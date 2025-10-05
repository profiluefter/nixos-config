{ pkgs, ... }:
{
  home.packages = with pkgs; [
    geogebra
  ];

  programs.bash.shellAliases = {
    heimo = "curl -s -d \"auth_user=$(cat /run/secrets/school-user)\" -d \"auth_pass=$(cat /run/secrets/school-password)\" -d 'accept=Anmelden' http://10.10.0.251:8002/index.php?zone=cp_htl";
  };
}
