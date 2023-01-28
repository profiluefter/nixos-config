{ ... }:
{
  # somehow doesn't work...

  #environment.etc."wireplumber/main.lua.d/90-soundcard.lua".text = ''
  #  rule = {
  #    matches = {
  #      {
  #        { "device.name", "equals", "alsa_card.usb-Burr-Brown_from_TI_USB_Audio_CODEC-00" },
  #      },
  #    },
  #    apply_properties = {
  #      ["api.alsa.use-acp"] = true,
  #      ["api.acp.auto-profile"] = false,
  #      ["api.acp.auto-port"] = false,
  #      ["device.profile-set"] = "texas-instruments-pcm2902.conf",
  #      ["device.profile"] = "output:analog-stereo-output+input:analog-mono",
  #    },
  #  }
  #
  #  table.insert(alsa_monitor.rules, rule)
  #'';

  home-manager.users.fabian.home.file.".local/state/wireplumber/default-profile".text = ''
    [default-profile]
    alsa_card.usb-Burr-Brown_from_TI_USB_Audio_CODEC-00=output:analog-stereo-output+input:analog-mono
  '';
}
