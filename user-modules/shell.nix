{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Fabian Gurtner";
    userEmail = "fabian.paul.gurtner@gmail.com";

    signing = {
      key = "61D3E3F22AA966EF";
      signByDefault = true;
    };

    delta.enable = true;
  };

  programs.ssh = {
    enable = true;
  };

  # TODO: make this work outside of a terminal session
  programs.bash.initExtra = "export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)";

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

    bashrcExtra = ''
      function load-gitlab-env() {
        export GITLAB_USERNAME=$(cat /run/secrets/gitlab-username)
        export GITLAB_ACCESS_TOKEN=$(cat /run/secrets/gitlab-personal-access-token)
      }
    '';
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
