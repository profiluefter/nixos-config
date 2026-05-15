{ ... }:
{
  flake.nixosModules.desktop-common =
    { pkgs, ... }:
    {
      fonts.packages = with pkgs; [
        corefonts
        noto-fonts
        noto-fonts-color-emoji
        liberation_ttf
        jetbrains-mono
        nerd-fonts.jetbrains-mono
        vista-fonts
      ];
    };
}
