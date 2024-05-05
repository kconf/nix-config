{ pkgs, user, ... }:
{
  home = {
    username = user.name;
    homeDirectory = "/home/${user.name}";
    stateVersion = "23.11";
    sessionPath = [ "$HOME/.local/bin" ];
  };

  home.packages = with pkgs; [
    trash-cli

    unar
    atool
    zip
    unzip

    nsxiv
    zathura

    restic
  ];

  programs.vim = {
    enable = true;
    defaultEditor = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
