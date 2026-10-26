{ pkgs, ... }:
{
  targets.genericLinux.enable = true;
  # Enable GPU integration only after identifying the new laptop's hardware.
  targets.genericLinux.gpu.enable = false;
  programs.home-manager.enable = true;
  xdg.enable = true;
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    curl
    wget
    ripgrep
    fd
    jq
    htop
    tree
    unzip
    zip
    rsync
    rclone
    tealdeer
    file
    which
    nerd-fonts.dejavu-sans-mono
  ];
  home.sessionPath = [ "$HOME/.local/bin" ];
  home.sessionVariables.EDITOR = "vim";
  nix.package = pkgs.nix;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
