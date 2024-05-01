{
  config,
  lib,
  ...
}: {
  options = {
    myNixos.pipewire.enable = lib.mkEnableOption "Enables pipewire";
  };

  config = lib.mkIf config.myNixos.pipewire.enable {
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };

      pulse.enable = true;
    };

    sound = {
      enable = true;
      mediaKeys.enable = true;
    };
  };
}
