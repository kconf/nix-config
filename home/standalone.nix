{ config, pkgs, ... }:

{
  imports = [
    ../modules/setting.nix
    ./base.nix
    ./editor.nix
    ./git.nix
    ./zsh.nix
  ];

  nix.package = pkgs.nix;
}
