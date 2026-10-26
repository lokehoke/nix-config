{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      core.editor = "vim";
      credential."https://github.com".helper = [
        ""
        "!${pkgs.gh}/bin/gh auth git-credential"
      ];
    };
    includes = [ { path = "~/.config/private/git.conf"; } ];
  };
  # Existing SSH hosts and Skotty config contain private infrastructure details.
  # Keep ~/.ssh/config unmanaged until it has been reviewed separately.
}
