{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    calibre
    clash-verge
    keepassxc
    microsoft-edge
    mpv
    obsidian
    obsidian
    quarto
    vscode
    wpsoffice-cn
    wpsoffice-cn
    zeal
    zotero
    config.nur.repos.xddxdd.dingtalk
    config.nur.repos.linyinfeng.wemeet
  ];
}
