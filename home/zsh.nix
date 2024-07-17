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
      e = "${pkgs.neovim}/bin/nvim";
      o = "xdg-open";
      f = "nnn -a";
      rm = "trash";
    };

    initExtra = ''
      cht() { curl cht.sh/$* }
      qr() { curl qrenco.de/$* }
      clone() { gh repo clone $1 $HOME/Dev/github.com/$1 }

      for f in $HOME/.zsh.d/*.sh(N); do
        source $f
      done
    '';
  };

  programs.fzf = {
    enable = true;
    changeDirWidgetCommand = "fd --type d";
  };

  programs.starship = {
    enable = true;
  };

  programs.eza.enable = true;
  programs.bat.enable = true;
  programs.ripgrep.enable = true;
  programs.zellij.enable = true;
  programs.zoxide.enable = true;

  programs.nnn = {
    enable = true;
    package = pkgs.nnn.override ({ withNerdIcons = true; });
    extraPackages = with pkgs; [
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

  home.packages = [ pkgs.fd ];
}
