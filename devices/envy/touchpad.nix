{ ... }:
{
  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad = {
    naturalScrolling = true;
    scrollMethod = "edge";
  };

  #   dmi:bvnInsyde:bvrF.28:bd04/01/2022:br15.28:efr70.31:svnHP:pnHPENVYx360Convertible15-cn0xxx:pvrType1ProductConfigId:rvnHP:rn8484:rvr70.31:cvnHP:ct31:cvrChassisVersion:sku4AV73EA#ABD:

  services.udev.extraHwdb = ''
    # Laptop model description (e.g. Lenovo X1 Carbon 5th)
    evdev:name:SynPS/2 Synaptics TouchPad:dmi:*svnHP:*pnHPENVYx360Convertible15-cn0xxx**
     EVDEV_ABS_00=::36
     EVDEV_ABS_01=::60
     EVDEV_ABS_35=::36
     EVDEV_ABS_36=::60
  '';
}
