{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.my.desktop.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
      mutableExtensionsDir = true;
      profiles.default = {
        userSettings = builtins.fromJSON (builtins.readFile ../config/vscode/settings.json);
        extensions =
          with pkgs.vscode-extensions;
          [
            ms-python.python
            ms-python.vscode-pylance
            ms-python.debugpy
            ms-vscode.cpptools
            ms-vscode-remote.remote-ssh
            ms-vscode-remote.remote-ssh-edit
            ms-vscode.remote-explorer
            ms-toolsai.jupyter-keymap
            ms-python.vscode-python-envs
            anthropic.claude-code
          ]
          ++ map (
            source:
            pkgs.vscode-utils.buildVscodeMarketplaceExtension {
              mktplcRef = builtins.removeAttrs source [ "url" ];
              vsix = pkgs.fetchurl {
                name = "${source.publisher}-${source.name}-${source.version}.vsix";
                inherit (source) url hash;
              };
            }
          ) (builtins.fromJSON (builtins.readFile ../inventory/vscode-marketplace.json));
      };
    };
    # All original extensions except Roo Code. AI: Claude Code and Codex only.
    # Existing AI permissions and MCP credentials are transferred privately.
  };
}
