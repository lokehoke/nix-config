{ pkgs }:
let
  sources = builtins.fromJSON (builtins.readFile ../inventory/vim-plugins.json);
in
map (
  source:
  pkgs.vimUtils.buildVimPlugin {
    pname = source.repo;
    version = builtins.substring 0 12 source.rev;
    src = pkgs.fetchFromGitHub {
      inherit (source)
        owner
        repo
        rev
        hash
        ;
    };
    # The only local changes were executable-bit removals on these two scripts.
    postPatch = pkgs.lib.optionalString (source.repo == "vim-colorschemes") ''
      chmod 0644 scripts/toremove scripts/toremove2
    '';
  }
) sources
