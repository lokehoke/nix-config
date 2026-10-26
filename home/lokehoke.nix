{ ... }:
{
  imports = [
    ../modules/options.nix
    ../modules/base.nix
    ../modules/shell.nix
    ../modules/tmux.nix
    ../modules/git.nix
    ../modules/development.nix
    ../modules/desktop.nix
    ../modules/editor.nix
    ../modules/audio.nix
    ../modules/ai.nix
  ];

  home.username = "lokehoke";
  home.homeDirectory = "/home/lokehoke";
  # Compatibility baseline for this configuration, not the Ubuntu version.
  home.stateVersion = "26.05";
}
