{ pkgs, ... }:
{
  # zsh
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    cdpath = [ "$HOME" ];

    shellAliases = {
      update = "sudo nixos-rebuild switch";
      g = "${pkgs.git}/bin/git";
      v = "${pkgs.neovim}/bin/nvim";
      n = "nnn -a";
    };

    initExtra = ''
      cht() { curl cht.sh/$* }
      qr() { curl qrenco.de/$* }
    '';
  };

  programs.lsd = {
    enable = true;
    enableAliases = true;
  };

  programs.fzf = {
    enable = true;
    changeDirWidgetCommand = "fd --type d";
  };

  programs.starship = {
    enable = true;
  };

  programs.zoxide.enable = true;

  programs.ripgrep.enable = true;

  programs.nnn = {
    enable = true;
    package = pkgs.nnn.override ({ withNerdIcons = true; });
    extraPackages = with pkgs; [
      st
      tabbed
      xdotool
    ];
    plugins = {
      src =
        (pkgs.fetchFromGitHub {
          owner = "jarun";
          repo = "nnn";
          rev = "v4.9";
          sha256 = "05ff2y6zbyqm3savq6ibq039jk8cz19jh445v72k9jw7gqinwpw3";
        })
        + "/plugins";
      mappings = {
        f = "finder";
        j = "autojump";
        p = "preview-tui";
        t = "nuke";
        v = "imgview";
        w = "preview-tabbed";
      };
    };
    bookmarks = {
      d = "~/Downloads/";
      D = "~/Documents/";
    };
  };

  programs.zellij = {
    enable = true;
  };

  home.packages = [ pkgs.fd ];
}