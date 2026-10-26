{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      core.editor = "vim";
    };
    includes = [ { path = "~/.config/private/git.conf"; } ];
  };
  # Existing SSH hosts and Skotty config contain private infrastructure details.
  # Keep ~/.ssh/config unmanaged until it has been reviewed separately.
}
