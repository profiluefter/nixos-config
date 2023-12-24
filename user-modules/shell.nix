{ pkgs, config, ... }:
{
  programs.bat.enable = true;
  programs.jq.enable = true;
  programs.micro.enable = true;

  home.packages = with pkgs; [
    tldr
    yt-dlp

    dig
    ldns
  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      cat = "bat";
      #      fnd = "";
      yt-music-dl = "yt-dlp -x --embed-thumbnail --embed-metadata --sponsorblock-remove music_offtopic";
      nix-update = "(cd ~/code/misc/nixos-config && exec nix flake update --commit-lock-file)";
      nix-upgrade = "sudo nixos-rebuild boot --flake git+file:///home/fabian/code/misc/nixos-config?ref=master -j 4 -L";
      nix-apply = "sudo nixos-rebuild switch --flake git+file:///home/fabian/code/misc/nixos-config?ref=master -j 4 -L";
      nix-test = "sudo nixos-rebuild test --flake ~/code/misc/nixos-config -j 4 -L";
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
    settings = { };
  };
}
