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

    files."kdeglobals" = {
      "KDE"."LookAndFeelPackage" = "org.kde.breezedark.desktop";
    };

    files."kdedefaults/kdeglobals" = {
      "General"."ColorScheme" = "BreezeDark";
      "Icons"."Theme" = "breeze-dark";
      "KDE"."widgetStyle" = "Breeze";
    };

    # .config/gtk-4.0/settings.ini
  };
}
