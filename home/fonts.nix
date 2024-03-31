{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # icon fonts
    material-design-icons

    # normal fonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    source-han-sans
    source-han-serif

    # nerdfonts
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "JetBrainsMono"
      ];
    })
  ];

  fonts.fontconfig.enable = true;
}
