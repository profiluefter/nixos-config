{ ... }:
{
  services.xserver.dpi = 160;

  services.autorandr = {
    enable = true;

    defaultTarget = "home";
    profiles."home" = {
  	  fingerprint = {
        "DP-0" = "00ffffffffffff004c2d4d0c46584d30291b0104b53d23783b5fb1a2574fa2280f5054230800810081c08180a9c0b3009500010101014dd000a0f0703e80302035005f592100001a000000fd00283c87873c010a202020202020000000fc00553238453539300a2020202020000000ff004854504a4130303336320a202001c302030ef041102309070783010000023a801871382d40582c45005f592100001e565e00a0a0a02950302035005f592100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000bf";
        "DP-2" = "00ffffffffffff0031030034000000001c1e0104a55022783beed5a3544c99230f5054bfef80d1c0b30095008180714f81c08140a940f57c70a0d0a02950302035001d4e3100001a000000fd003064a1a13c010a202020202020000000fc0055575148442d3130302d430a20000000ff003030303030303030303030303001a1020314744c3f010203040510111213141f23090743d070a0d0a02950302035001d4e3100001aa348b86861a03250304035001d4e3100001e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f9";
      };

      config = {
        # 1440p ultrawide middle
        "DP-2" = {
          primary = true;
          position = "0x720";
          mode = "3440x1440";
          rate = "100.00";
          #dpi = 110;
        };
  	    # 4k right
        "DP-0" = {
          position = "3440x0";
          mode = "3840x2160";
          rate = "60.00";
          #dpi = 160;
        };
      };

      hooks.postswitch = {
        "fix-nvidia" = "nvidia-settings --assign CurrentMetaMode=\"DP-2: 3440x1440_100 +0+0 {viewportin=5160x2160}, DP-0: 3840x2160_60 +5160+0\"";
        # combined mode: 9000x2160
        # ultrawide meta mode: 5160x2160
        /*
Section "Screen"
    Identifier     "Screen0"
    Device         "Device0"
    Monitor        "Monitor0"
    DefaultDepth    24
    Option         "Stereo" "0"
    Option         "nvidiaXineramaInfoOrder" "DFP-5"
    Option         "metamodes" "DP-2: 3440x1440_100 +0+0 {viewportin=5160x2160}, DP-0: 3840x2160_60 +5160+0"
    Option         "SLI" "Off"
    Option         "MultiGPU" "Off"
    Option         "BaseMosaic" "off"
    SubSection     "Display"
        Depth       24
    EndSubSection
EndSection
        */
      };
    };
  };
}
