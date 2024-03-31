{
  pkgs,
  config,
  lib,
  dpi,
  ...
}:
{
  programs.rofi = {
    enable = true;
    font = "monospace 14";
    extraConfig = {
      inherit dpi;
    };
  };

  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    font = {
      name = "monospace";
      size = 14;
    };
    settings = {
      allow_remote_control = "yes";
      listen_on = "unix:@kitty";
      enable_layouts = "splits";
    };
  };

  home.pointerCursor = {
    name = "DMZ-White";
    package = pkgs.vanilla-dmz;
    size = 64;
    gtk.enable = true;
  };

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "${pkgs.kitty}/bin/kitty";
      menu = ''"${pkgs.rofi}/bin/rofi -show combi -combi-modes window,run,ssh -modes combi"'';
      workspaceAutoBackAndForth = true;
      defaultWorkspace = "workspace number 1";
      fonts = {
        names = [ "monospace" ];
        size = 11.0;
      };
      startup = [
        {
          command = "fcitx5";
          always = true;
        }
        {
          command = "${pkgs.i3wsr}/bin/i3wsr";
          always = true;
          notification = false;
        }
        {
          command = "${pkgs.autorandr}/bin/autorandr -c";
          always = true;
          notification = false;
        }
      ];
      keybindings =
        let
          mod = config.xsession.windowManager.i3.config.modifier;
        in
        lib.mkOptionDefault {
          "Print" = ''exec "maim -s ~/Documents/ss/$(date +%s).png"'';
          "${mod}+Print" = ''exec "maim ~/Documents/ss/$(date +%s).png"'';
          "${mod}+b" = "workspace back_and_forth";
          "${mod}+Shift+b" = "move container to workspace back_and_forth";
          "${mod}+n" = "move workspace to output next";
          "${mod}+Ctrl+n" = "move container to output next";
          "XF86AudioMute" = "exec amixer -q set Master toggle";
          "XF86AudioLowerVolume" = "exec amixer -q set Master 5%- unmute";
          "XF86AudioRaiseVolume" = "exec amixer -q set Master 5%+ unmute";
        };
      bars = [
        {
          fonts = {
            names = [ "monospace" ];
            size = 12.0;
          };
          statusCommand = "i3status-rs ${config.xdg.configHome}/i3status-rust/config-default.toml";
        }
      ];
    };
  };

  xdg.configFile."i3wsr/config.toml".text = ''
    [icons]
    "Microsoft-edge" = ""
    Thunar = ""
    kitty = ""
    KeePassXC = ""
    obsidian = ""
    wps = "󱔘"
    code-oss = ""

    [general]
    default_icon = ""
    split_at = ":"
    empty_label = "🌕"
    display_property = "instance"

    [options]
    remove_duplicates = true
    no_names = false
    no_icon_names = false
  '';

  programs.i3status-rust = {
    enable = true;
    bars = {
      default = {
        icons = "material-nf";
        theme = "gruvbox-dark";
        blocks = [
          {
            alert = 10.0;
            block = "disk_space";
            info_type = "available";
            interval = 60;
            path = "/";
            warning = 20.0;
          }
          {
            block = "memory";
            format = " $icon $mem_used_percents ";
            format_alt = " $icon $swap_used_percents ";
          }
          {
            block = "load";
            format = " $icon $1m ";
            interval = 1;
          }
          {
            block = "battery";
            format = " $icon $percentage ";
          }
          { block = "sound"; }
          {
            block = "time";
            format = " $timestamp.datetime(f:'%a %d/%m %R') ";
            interval = 60;
          }
        ];
      };
    };
  };
}
