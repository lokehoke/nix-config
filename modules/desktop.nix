{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.my.desktop.enable {
    home.packages = with pkgs; [
      firefox
      chromium
      thunderbird
      telegram-desktop
      discord
      zoom-us
      postman
      obsidian
      libreoffice-fresh
      gimp
      vlc
      flameshot
      remmina
      transmission_4-gtk
      pavucontrol
    ];
    # Profiles remain mutable data. Do not migrate databases through home.file.
    # GPU drivers, portals, keyring, VPN and audio services belong to Ubuntu.
  };
}
