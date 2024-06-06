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
        rev = "v1.1";
        sha256 = "sha256-GAAL4WjmcMiuzgAyftW4aX1lLhj3u13tMF+8gHAtojs=";
      })
      + "/.config/nvim";
    recursive = true;
  };
}
