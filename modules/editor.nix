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
        extensions = with pkgs.vscode-extensions; [
          ms-python.python
          ms-python.vscode-pylance
          ms-python.debugpy
          ms-vscode.cpptools
          ms-vscode-remote.remote-ssh
          ms-vscode-remote.remote-ssh-edit
          ms-vscode.remote-explorer
          ms-toolsai.jupyter-keymap
        ];
      };
    };
    # Remaining original IDs/versions: inventory/vscode-extensions.json.
    # AI extension permissions and MCP settings were deliberately not imported.
  };
}
