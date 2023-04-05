{ pkgs, config, ... }:
{
  programs.bat.enable = true;
  programs.jq.enable = true;

  # not yet released?
  #programs.micro = {
  #  enable = true;
  #};
  home.packages = [
    pkgs.micro
    pkgs.tldr
    pkgs.yt-dlp
  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      heimo = "curl -s -d \"auth_user=$(cat /run/secrets/schoolUser)\" -d \"auth_pass=$(cat /run/secrets/schoolPassword)\" -d 'accept=Anmelden' http://10.10.0.251:8002/index.php?zone=cp_htl";
      cat = "bat";
#      fnd = "";
      yt-music-dl = "yt-dlp -x --embed-thumbnail --embed-metadata --sponsorblock-remove music_offtopic";
      nix-update = "(cd ~/code/misc/nixos-config && exec nix flake update)";
      nix-upgrade = "sudo nixos-rebuild switch --flake ~/code/misc/nixos-config";
    };
  };

  programs.fzf = {
    enable = true;
#    defaultCommand = ""; # TODO: search files and exclude "result" folder from nix
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.starship = {
    enable = true;
    settings = {

    };
  };
}
