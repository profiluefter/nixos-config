{ pkgs, lib2, config, ... }:
{
  home.packages = with pkgs; lib2.mkIfWorkload config "latex" [
    lyx
    (texlive.combine {
      inherit (texlive) scheme-medium
        csquotes
        multirow
        glossaries
        glossaries-extra
        mfirstuc
        xfor
        datatool
        xpatch
        ;
    })
  ];
}
