{ config, lib, ... }:
{
  programs.zsh = {
    enable = true;
    dotDir = config.home.homeDirectory;
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" ];
    };
    shellAliases = {
      cl = "clear";
      c = "clear";
      lc = "clear";
      cle = "clear";
      clea = "clear";
      sl = "ls";
      l = "ls -lah";
      lol = "cd ~/__my/lol/";
      up = "sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y";
      cvm = "\"$HOME/scripts/ssh_vm.sh\"";
    };
    initContent = ''
      # This file stays outside Git and the Nix store. Never interpolate its contents.
      if [[ -r "$HOME/.config/private/shell.zsh" ]]; then
        source "$HOME/.config/private/shell.zsh"
      fi
    ''
    + lib.optionalString config.my.shell.autoTmux ''
      if [[ -o interactive && -t 0 && -t 1 && -z "$TMUX" && -z "$INSIDE_EMACS" ]]; then
        tmux new-session -A -s home
      fi
    '';
  };
}
