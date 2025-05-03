{
  lib2,
  config,
  pkgs,
  ...
}:
{
  home.packages =
    with pkgs;
    lib2.mkIfWorkload config "ctf" [
      ghidra-bin
    ];
}
