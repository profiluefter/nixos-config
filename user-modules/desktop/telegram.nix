{ pkgs, ... }:
{
  home.packages = [
    pkgs.tdesktop
  ];

  home.file.".config/autostart/org.telegram.desktop.desktop" = {
    text = ''
      [Desktop Entry]
      Name=Telegram Desktop
      Comment=Official desktop version of Telegram messaging app
      TryExec=telegram-desktop
      Exec=telegram-desktop -autostart
      Icon=telegram
      Terminal=false
      StartupWMClass=TelegramDesktop
      Type=Application
      Categories=Chat;Network;InstantMessaging;Qt;
      MimeType=x-scheme-handler/tg;
      Keywords=tg;chat;im;messaging;messenger;sms;tdesktop;
      Actions=quit;
      DBusActivatable=true
      SingleMainWindow=true
      X-GNOME-UsesNotifications=true
      X-GNOME-SingleWindow=true
    '';
  };
}
