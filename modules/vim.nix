{ vimPlugins, ... }:
{
  programs.vim = {
    enable = true;
    defaultEditor = true;
    plugins = vimPlugins;
    extraConfig = builtins.readFile ../config/vim/vimrc;
  };
}
