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
      cat = "bat";
#      fnd = "";
      yt-music-dl = "yt-dlp -x --embed-thumbnail --embed-metadata --sponsorblock-remove music_offtopic";
      nix-update = "(cd ~/code/misc/nixos-config && exec nix flake update)";
      nix-upgrade = "sudo nixos-rebuild boot --flake ~/code/misc/nixos-config";
      nix-apply = "sudo nixos-rebuild switch --flake ~/code/misc/nixos-config";
      nix-test = "sudo nixos-rebuild test --flake ~/code/misc/nixos-config";
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
