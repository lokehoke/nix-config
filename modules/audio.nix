{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.my.audio.enable {
    home.packages = with pkgs; [
      reaper
      ardour
      qjackctl
    ];
    # Ubuntu manages JACK/PipeWire, device access and real-time scheduling.
    # Presets, VST3, licenses and recorded audio are restored separately.
  };
}
