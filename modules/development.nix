{ pkgs, ... }:
{
  programs.vim.enable = true;
  home.packages = with pkgs; [
    nodejs_22
    python3
    uv
    gcc
    gnumake
    cmake
    pkg-config
  ];
  # Libraries, notebooks and Jupyter belong in project-specific devShells.
  # Do not copy mutable NVM installations or Python site-packages into the store.
}
