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
        rev = "v1.0";
        sha256 = "19p1s3g5ac7cn9gqpam9ig543z0xk9xv6g1818k54zlgiky9nai3";
      })
      + "/.config/nvim";
    recursive = true;
  };
}
