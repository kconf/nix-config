{ pkgs, user, ... }:
{
  # neovim
  programs.neovim = {
    enable = true;
  };
  xdg.configFile."nvim" = {
    source =
      (pkgs.fetchFromGitHub {
        owner = "kconf";
        repo = "neovim";
        rev = "v1.2";
        sha256 = "sha256-N/ACfnSYQ9pRsMpCB3uEglsEvsvtRiiLPbpAfx7MFr4=";
      })
      + "/.config/nvim";
    recursive = true;
  };
}
