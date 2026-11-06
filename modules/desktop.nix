{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.my.desktop.enable {
    home.packages = with pkgs; [
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
      evince
      eog
      totem
      gedit
      file-roller
      nautilus
      rhythmbox
    ];

    dconf.settings = {
      "org/gnome/desktop/input-sources".xkb-options = [
        "ctrl:nocaps"
        "grp:alt_shift_toggle"
      ];
      "org/gnome/shell/keybindings".show-screenshot-ui = lib.hm.gvariant.mkEmptyArray lib.hm.gvariant.type.string;
      "org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot/"
      ];
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot" = {
        name = "Flameshot";
        command = "${pkgs.flameshot}/bin/flameshot gui";
        binding = "Print";
      };
    };

    # Profiles remain mutable data. Do not migrate databases through home.file.
    # GPU drivers, portals, keyring, VPN and audio services belong to Ubuntu.
  };
}
