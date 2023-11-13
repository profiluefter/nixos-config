{ pkgs, lib, config, ... }:
let
  #  unstable = fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
  #  nixpkgs = import unstable {
  #    config.allowUnfree = true;
  #    config.android_sdk.accept_license = true;
  #  };
  androidComposition = pkgs.unstable.androidenv.composeAndroidPackages {
    platformVersions = [ "32" ];
    buildToolsVersions = [ "30.0.3" ];
  };
in
{
  config = lib.mkIf (builtins.elem "android" config.profi.workloads) {
    home.packages = [
      androidComposition.androidsdk
    ];

    systemd.user.sessionVariables = {
      ANDROID_SDK_ROOT = "${androidComposition.androidsdk}/libexec/android-sdk";
    };
  };
}
