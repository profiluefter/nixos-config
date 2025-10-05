{ pkgs, ... }:
let
  androidComposition = pkgs.unstable.androidenv.composeAndroidPackages {
    platformVersions = [ "32" ];
    buildToolsVersions = [ "30.0.3" ];
  };
in
{
  home.packages = [
    androidComposition.androidsdk
  ];

  systemd.user.sessionVariables = {
    ANDROID_SDK_ROOT = "${androidComposition.androidsdk}/libexec/android-sdk";
  };
}
