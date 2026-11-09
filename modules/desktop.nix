{
  config,
  lib,
  pkgs,
  ...
}:
let
  yaruCursors = pkgs.runCommand "yaru-cursors" { } ''
    mkdir -p "$out/share/icons/Yaru"
    ln -s ${pkgs.yaru-theme}/share/icons/Yaru/cursors "$out/share/icons/Yaru/cursors"
  '';
  telegram = pkgs.symlinkJoin {
    name = "telegram-desktop-with-cursor";
    paths = [ pkgs.telegram-desktop ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram "$out/bin/Telegram" \
        --set XCURSOR_THEME "${config.home.pointerCursor.name}" \
        --set XCURSOR_SIZE "${toString config.home.pointerCursor.size}" \
        --prefix XCURSOR_PATH : "${config.home.pointerCursor.package}/share/icons"

      desktopFile=share/applications/org.telegram.desktop.desktop
      rm "$out/$desktopFile"
      substitute "${pkgs.telegram-desktop}/$desktopFile" "$out/$desktopFile" \
        --replace-fail "Exec=Telegram" "Exec=$out/bin/Telegram"

      serviceFile=share/dbus-1/services/org.telegram.desktop.service
      rm "$out/$serviceFile"
      substitute "${pkgs.telegram-desktop}/$serviceFile" "$out/$serviceFile" \
        --replace-fail "${pkgs.telegram-desktop}/bin/Telegram" "$out/bin/Telegram"
    '';
    meta = pkgs.telegram-desktop.meta;
  };
in
{
  config = lib.mkIf config.my.desktop.enable {
    home.packages = with pkgs; [
      telegram
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
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

    home.pointerCursor = {
      package = yaruCursors;
      name = "Yaru";
      size = 48;
      x11.enable = true;
    };

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
