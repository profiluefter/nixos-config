{stdenv}:
stdenv.mkDerivation {
  name = "autostart-telegramdesktop";
  priority = 5;

  buildCommand = ''
    mkdir -p $out/etc/xdg/autostart
    target=telegramdesktop.desktop

    cat << EOF
    [Desktop Entry]
    Name=Telegram Desktop
    Comment=Official desktop version of Telegram messaging app
    TryExec=telegram-desktop
    Exec=telegram-desktop -- %u
    Icon=telegram
    Terminal=false
    StartupWMClass=TelegramDesktop
    Type=Application
    Categories=Chat;Network;InstantMessaging;Qt;
    MimeType=x-scheme-handler/tg;
    Keywords=tg;chat;im;messaging;messenger;sms;tdesktop;
    Actions=Quit;
    SingleMainWindow=true
    X-GNOME-UsesNotifications=true
    X-GNOME-SingleWindow=true
    X-KDE-autostart-phase=2

    [Desktop Action Quit]
    Exec=telegram-desktop -quit
    Name=Quit Telegram
    Icon=application-exit
    EOF > $target
    chmod +rw $target

    cp $target $out/etc/xdg/autostart
  '';
}