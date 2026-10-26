{ lib, ... }:
{
  options.my = {
    desktop.enable = lib.mkEnableOption "desktop applications";
    audio.enable = lib.mkEnableOption "audio production applications";
    ai.enable = lib.mkEnableOption "Codex and Claude command line applications";
    shell.autoTmux = lib.mkEnableOption "automatic tmux attachment in interactive terminals";
  };
}
