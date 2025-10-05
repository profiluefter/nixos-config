{ pkgs, ... }:
{
  programs.java.enable = true;

  home.packages = with pkgs; [
    nodejs
    yarn
    rustup
    gcc
  ];
}
