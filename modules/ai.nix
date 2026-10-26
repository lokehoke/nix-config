{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.my.ai.enable {
    home.packages = with pkgs; [
      codex
      claude-code
    ];
    # Authentication, chats, generated files and MCP credentials stay outside Nix.
  };
}
