{ ... }:
{
  flake.modules.nixos.desktop-common =
    { pkgs, ... }:
    {
      fonts.packages = with pkgs; [
        corefonts
        noto-fonts
        noto-fonts-emoji
        liberation_ttf
        jetbrains-mono
        nerd-fonts.jetbrains-mono
        vistafonts
      ];
    };
}
