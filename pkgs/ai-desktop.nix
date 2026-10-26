{ pkgs }:
let
  sources = builtins.fromJSON (builtins.readFile ../inventory/ai-desktop-sources.json);
  mkDesktop =
    name: command: desktopFile:
    let
      source = sources.${name};
      vendor = pkgs.stdenvNoCC.mkDerivation {
        pname = "${name}-vendor";
        inherit (source) version;
        src = pkgs.fetchurl { inherit (source) url hash; };
        nativeBuildInputs = [ pkgs.dpkg ];
        dontUnpack = true;
        dontBuild = true;
        dontFixup = true;
        installPhase = ''
          runHook preInstall
          mkdir -p unpacked "$out"
          # Nix store packages cannot retain privileged ownership/mode bits.
          dpkg-deb --fsys-tarfile "$src" | tar --extract \
            --no-same-owner --no-same-permissions --directory unpacked
          cp -a unpacked/usr/. "$out/"
          runHook postInstall
        '';
      };
    in
    pkgs.buildFHSEnv {
      name = command;
      inherit (source) version;
      targetPkgs = p: [
        vendor
        p.bash
        p.coreutils
        p.glibc
        p.glib
        p.gtk3
        p.gdk-pixbuf
        p.nss
        p.nspr
        p.at-spi2-atk
        p.at-spi2-core
        p.cups
        p.dbus
        p.alsa-lib
        p.libdrm
        p.mesa
        p.libglvnd
        p.libxkbcommon
        p.libnotify
        p.systemd
        p.libsecret
        p.pipewire
        p.expat
        p.pango
        p.cairo
        p.openssl
        p.tpm2-tss
        p.libusb1
        p.libuuid
        p.xdg-utils
        p.cacert
        p.stdenv.cc.cc.lib
        p.zlib
        p.xz
        p.libx11
        p.libxcb
        p.libxcomposite
        p.libxdamage
        p.libxext
        p.libxfixes
        p.libxrandr
        p.libxtst
      ];
      runScript = "/usr/bin/${command}";
      extraInstallCommands = ''
        mkdir -p "$out/share/applications"
        cp "${vendor}/share/applications/${desktopFile}" "$out/share/applications/"
        substituteInPlace "$out/share/applications/${desktopFile}" \
          --replace-warn "Exec=${command}" "Exec=$out/bin/${command}" \
          --replace-warn "TryExec=${command}" "TryExec=$out/bin/${command}"
        if [ -d "${vendor}/share/icons" ]; then
          cp -a "${vendor}/share/icons" "$out/share/"
        fi
        if [ -d "${vendor}/share/pixmaps" ]; then
          cp -a "${vendor}/share/pixmaps" "$out/share/"
        fi
      '';
      meta = {
        description = "Official ${name} Linux desktop application in an FHS environment";
        license = pkgs.lib.licenses.unfree;
        platforms = [ "x86_64-linux" ];
        mainProgram = command;
      };
    };
in
{
  codex-desktop = mkDesktop "chatgpt" "chatgpt" "chatgpt.desktop";
  claude-desktop = mkDesktop "claude-desktop" "claude-desktop" "com.anthropic.Claude.desktop";
}
