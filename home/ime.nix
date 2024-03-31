{ pkgs, ... }:
let
  fcitx5-rime = pkgs.fcitx5-rime.override {
    rimeDataPkgs = [
      (pkgs.fetchFromGitHub {
        owner = "kconf";
        repo = "rime";
        rev = "v1.0";
        sha256 = "1zDVaVFr6wf6E89I42U4ohaRbZjcKsvLl/W9YHjslj4=";
      })
    ];
  };
in
{
  # Chinese related
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = [
      fcitx5-rime
      pkgs.fcitx5-nord
      pkgs.fcitx5-configtool
    ];
  };
}
