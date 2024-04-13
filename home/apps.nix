{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    clash-verge
    keepassxc
    microsoft-edge
    obsidian
    quarto
    vscode
    wpsoffice-cn
    zeal
    zotero
    config.nur.repos.xddxdd.dingtalk
    config.nur.repos.linyinfeng.wemeet
  ];
}