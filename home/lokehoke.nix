{ ... }:
{
  imports = [
    ../modules/options.nix
    ../modules/base.nix
    ../modules/cli.nix
    ../modules/shell.nix
    ../modules/tmux.nix
    ../modules/git.nix
    ../modules/development.nix
    ../modules/vim.nix
    ../modules/desktop.nix
    ../modules/editor.nix
    ../modules/default-applications.nix
    ../modules/ai.nix
  ];

  my.shell.autoTmux = true;
  my.ai.enable = true;

  home.username = "lokehoke";
  home.homeDirectory = "/home/lokehoke";
  # Compatibility baseline for this configuration, not the Ubuntu version.
  home.stateVersion = "26.05";
}
