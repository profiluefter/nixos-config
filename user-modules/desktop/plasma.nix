{ pkgs, config, lib, lib2, ... }:
{
  home.packages = with pkgs; lib2.mkIfWorkload config "desktop" [
    ark
  ];

  # https://github.com/pjones/plasma-manager/blob/trunk/example/home.nix
  programs.plasma = lib2.mkIfWorkload config "desktop" {
    enable = true;

    workspace = {
      clickItemTo = "select";
      wallpaper = builtins.fetchurl {
        url = "https://drive.google.com/uc?export=download&id=1q-liWOtp6nDQVfj3_p1R_TAfvaOsHdH_";
        sha256 = "1k8mgjpq3075nbp7h6qkkmzal4y9gl0wpvy8hn3cjl5pyxbmsxm6";
        name = "background-intellij";
      };
    };

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

    spectacle.shortcuts = {
      captureRectangularRegion = "Print";
      captureCurrentMonitor = "Shift+Print";
    };

    panels = [
      {
        # bottom task bar
        height = 44;
        minLength = 1920;
        location = "floating";
        widgets = [
          "org.kde.plasma.kickoff"
          "org.kde.plasma.pager"
          "org.kde.plasma.icontasks"
          "org.kde.plasma.marginsseperator"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
          "org.kde.plasma.showdesktop"
        ];
      }
    ];

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
      # TODO: find a way to set this without clearing all defaults
      #      "AC.PowerProfile"."profile" = "performance";
      #      "AC.SuspendSession"."idleTime" = null;
      #      "AC.SuspendSession"."suspendType" = null;
      #      "Battery.PowerProfile"."profile" = "balanced";
      #      "LowBattery.PowerProfile"."profile" = "power-saver";
    };

    # .config/gtk-4.0/settings.ini
  };
}
