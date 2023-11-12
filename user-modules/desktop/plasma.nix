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

    configFile."powermanagementprofilesrc" = {
      "AC.PowerProfile"."profile" = "performance";
      "AC.SuspendSession"."idleTime" = null;
      "AC.SuspendSession"."suspendType" = null;
      "Battery.PowerProfile"."profile" = "balanced";
      "LowBattery.PowerProfile"."profile" = "power-saver";
    };

#    configFile."plasma-org.kde.plasma.desktop-appletsrc" = {
#      "Containments.1.Wallpaper.org.kde.image.General"."Image" = "file:///home/fabian/Downloads/wallhaven-3lrp5y.jpg"; # TODO: make derivation
#    };

    # .config/gtk-4.0/settings.ini
  };

  programs.bash.bashrcExtra = ''
    plasma-apply-wallpaperimage ${builtins.fetchurl {
      url = "https://drive.google.com/uc?export=download&id=1q-liWOtp6nDQVfj3_p1R_TAfvaOsHdH_";
      sha256 = "1k8mgjpq3075nbp7h6qkkmzal4y9gl0wpvy8hn3cjl5pyxbmsxm6";
      name = "background-intellij";
    }}
  '';
}
