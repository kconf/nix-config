{ pkgs, user, ... }:
{
  imports = [
    ./apps.nix
    ./dev.nix
    ./display.nix
    ./files.nix
    ./fonts.nix
    ./git.nix
    ./i3.nix
    ./ime.nix
    ./zsh.nix
  ];

  home = {
    username = user.name;
    homeDirectory = "/home/${user.name}";
    stateVersion = "23.05";
  };

  home.packages = with pkgs; [
    nixfmt-rfc-style

    file
    trash-cli

    unar
    atool
    zip
    unzip

    mpv
    nsxiv
    zathura
  ];

  # neovim
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      gcc # required by nvim-treesitter
    ];
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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
