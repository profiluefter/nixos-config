{ pkgs, ... }:
{
  home.packages = with pkgs; [
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
