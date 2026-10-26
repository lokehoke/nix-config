{ pkgs, ... }:
{
  # Preserve the existing gpakosz configuration and its theme as a unit.
  # Do not enable programs.tmux as well: it would generate a second config.
  home.packages = [ pkgs.tmux ];
  home.file.".tmux.conf".source = ../config/tmux/tmux.conf;
  home.file.".tmux.conf.local".source = ../config/tmux/tmux.conf.local;
}
