{ ... }:
{
  flake.nixosModules.default =
    { pkgs, ... }:
    {
      # List packages installed in system profile. To search, run:
      # $ nix search wget
      environment.systemPackages = [
        # FIXME: xournalpp workaround
        pkgs.adwaita-icon-theme
        pkgs.shared-mime-info

        pkgs.file
        pkgs.htop
        pkgs.micro
        pkgs.vim
        pkgs.wget
        pkgs.killall
      ];

      environment.pathsToLink = [
        "/share/icons"
        "/share/mime"
        "/share/bash-completion" # for better bash completion according to home-manager docs
      ];
    };
}
