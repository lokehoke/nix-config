{ config, lib, ... }:
{
  config = lib.mkIf config.my.desktop.enable {
    xdg.mimeApps = (builtins.fromJSON (builtins.readFile ../config/desktop/mimeapps.json)) // {
      enable = true;
    };
  };
}
