{
  config,
  lib,
  pkgs,
  aiDesktop,
  ...
}:
{
  config = lib.mkIf config.my.ai.enable {
    home.packages =
      with pkgs;
      [
        codex
        claude-code
      ]
      ++ lib.optionals config.my.desktop.enable [
        aiDesktop.codex-desktop
        aiDesktop.claude-desktop
      ];
    xdg.desktopEntries.claude-code-url-handler = {
      name = "Claude Code URL Handler";
      exec = "${pkgs.claude-code}/bin/claude --handle-uri %u";
      noDisplay = true;
      mimeType = [ "x-scheme-handler/claude-cli" ];
      type = "Application";
    };
    xdg.desktopEntries.chatgpt = lib.mkIf config.my.desktop.enable {
      name = "ChatGPT";
      # Preserve the current user desktop launch flag, independently of vendor defaults.
      exec = "${aiDesktop.codex-desktop}/bin/chatgpt --disable-gpu-compositing %U";
      icon = "chatgpt";
      categories = [
        "Utility"
        "Development"
      ];
      mimeType = builtins.fromJSON (builtins.readFile ../config/codex/desktop-mime-types.json);
      type = "Application";
      startupNotify = true;
    };
    # Seed only new installations; desktop applications need writable settings.
    home.activation.seedAiPreferences = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [[ ! -e "$HOME/.codex/config.toml" ]]; then
        run install -Dm600 ${../config/codex/preferences.toml} "$HOME/.codex/config.toml"
      fi
      if [[ ! -e "$HOME/.claude/settings.json" ]]; then
        run install -Dm600 ${../config/claude/settings.json} "$HOME/.claude/settings.json"
      fi
    '';
    # All existing state is listed in inventory/private-transfer.json, never sourced into the store.
  };
}
