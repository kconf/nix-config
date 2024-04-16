{ pkgs, ... }:
{
  home.packages = with pkgs; [
    devenv
    conda
  ];
}
