{ pkgs, config, lib2, ... }:
{
  home.packages = with pkgs; lib2.mkIfWorkload config "desktop" [
    ark
  ];

  # https://github.com/pjones/plasma-manager/blob/trunk/example/home.nix
  programs.plasma = lib2.mkIfWorkload config "desktop" {
    enable = true;

    workspace.clickItemTo = "select";

    hotkeys.commands = {
      "Launch Konsole" = {
        key = "Meta+K";
        command = "konsole";
      };
    };

    shortcuts = {
      ksmserver = {
        "Lock Session" = [ "Screensaver" "Meta+L" ];
      };

      yakuake.toggle-window-state = [ "Ctrl+F12" ];
    };

    configFile."kdeglobals" = {
      "KDE"."LookAndFeelPackage" = "org.kde.breezedark.desktop";
      "General"."fixed" = "JetBrainsMono Nerd Font,10,-1,5,50,0,0,0,0,0";
    };

    configFile."kdedefaults/kdeglobals" = {
      "General"."ColorScheme" = "BreezeDark";
      "Icons"."Theme" = "breeze-dark";
      "KDE"."widgetStyle" = "Breeze";
    };

#    configFile."plasma-org.kde.plasma.desktop-appletsrc" = {
#      "Containments.1.Wallpaper.org.kde.image.General"."Image" = "file:///home/fabian/Downloads/wallhaven-3lrp5y.jpg"; # TODO: make derivation
#    };

    # .config/gtk-4.0/settings.ini
  };

  programs.bash.bashrcExtra = ''
    plasma-apply-wallpaperimage ${builtins.fetchurl {
      url = "https://w.wallhaven.cc/full/3l/wallhaven-3lrp5y.jpg";
      sha256 = "0a9p7r9v9sagxmh9c6r0x9i9j71w5ndrc1ih3gaxy1sak5jfz9xy";
    }}
  '';
}
