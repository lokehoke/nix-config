{ pkgs, ... }:
{
  # User-facing CLI tools; Ubuntu keeps system services and hardware management.
  home.packages = with pkgs; [
    bash
    coreutils
    diffutils
    findutils
    gnugrep
    gnused
    gawk
    gnupg
    openssh
    curl
    wget
    ripgrep
    fd
    jq
    htop
    tree
    file
    which
    less
    bc
    unzip
    zip
    gzip
    gnutar
    xz
    rsync
    rclone
    tealdeer
    gh
    links2
    fastfetch
    f3
    tesseract
    ghostscript
    gnutls
    nssTools
    opensc
    esptool
    protontricks
    (writeShellScriptBin "neofetch" ''
      exec ${fastfetch}/bin/fastfetch "$@"
    '')
  ];
}
