{ pkgs, ... }:
{
  imports = [
    ./base.nix
    ./apps.nix
    ./dev.nix
    ./display.nix
    ./editor.nix
    ./fonts.nix
    ./git.nix
    ./i3.nix
    ./ime.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    nixfmt-rfc-style
    gnumake
    gcc # required by nvim-treesitter
    file
  ];
}
