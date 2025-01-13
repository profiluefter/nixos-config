{ pkgs, lib2, config, ... }:
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

  programs.gpg = {
    enable = true;
  };

  programs.ssh = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryPackage = if lib2.hasWorkload config "desktop" then pkgs.pinentry-qt else pkgs.pinentry-curses;
    sshKeys = [ "F14AB18A69F3A862C4AB47DAF3C49AFC6A443015" ];
  };

  # TODO: make this work outside of a terminal session
  programs.bash.initExtra = "export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)";

  home.packages = lib2.mkIfWorkload config "desktop" [ pkgs.kleopatra ];
}
