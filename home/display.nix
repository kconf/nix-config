{ dpi, ... }:
let
  monitors = {
    dell4k = {
      fingerprint = "00ffffffffffff0010acbea04c3941300d190104b5351e783ae245a8554da3260b5054a54b00714f8180a9c0a940d1c0e100d10001014dd000a0f0703e803e3035000f282100001a000000ff004654464b4e3533503041394c0a000000fc0044454c4c205032343135510a20000000fd001d4c1e8c36000a20202020202001db02031df15090050402071601141f121320212203062309070783010000023a801871382d40582c25000f282100001e011d8018711c1620582c25000f282100009e565e00a0a0a02950302035000f282100001a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000003d";
    };

    moe = {
      fingerprint = "00ffffffffffff000610c79c0000000024130103801d12780ae585a3544f9c260e505400000001010101010101010101010101010101521c008f50202e30302036001eb310000019000000010006102000000000000000000a20000000fe004c544e31333341543039000a20000000fc00436f6c6f72204c43440a202020003e";
    };

    mako = {
      fingerprint = "00ffffffffffff00061020a00000000004170104a51d1278026fb1a7554c9e250c505400000001010101010101010101010101010101e26800a0a0402e60302036001eb31000001a000000fc00436f6c6f72204c43440a2020200000001000000000000000000000000000000000001000000000000000000000000000000086";
    };
  };
  mkProfile =
    {
      monitor,
      port,
      mode,
    }:
    {
      fingerprint = {
        ${port} = monitors.${monitor}.fingerprint;
      };
      config = {
        ${port} = {
          mode = "${mode}";
        };
      };
    };

  mkDualProfile =
    {
      monitor1,
      port1,
      mode1,
      pos1,
      monitor2,
      port2,
      mode2,
      pos2,
    }:
    {
      fingerprint = {
        ${port1} = monitors.${monitor1}.fingerprint;
        ${port2} = monitors.${monitor2}.fingerprint;
      };
      config = {
        ${port1} = {
          primary = true;
          mode = "${mode1}";
          position = "${pos1}";
        };
        ${port2} = {
          mode = "${mode2}";
          position = "${pos2}";
        };
      };
    };
in
{
  home.file.".Xresources".text = ''
    Xft.dpi: ${builtins.toString dpi}
  '';
  home.file.".xinitrc".text = ''
    if xrandr | grep "DP-1 connected"; then
      xrandr --newmode "3840x2160_30.00"  339.57  3840 4080 4496 5152  2160 2161 2164 2197  -hsync +vsync
      xrandr --addmode DP-1 "3840x2160_30.00"
    fi

    xrdb -merge $HOME/.Xresources
    exec i3
  '';

  programs.autorandr = {
    enable = true;

    profiles = {
      moe = mkProfile {
        monitor = "moe";
        port = "LVDS-1";
        mode = "1280x800";
      };

      moe-dell = mkDualProfile {
        monitor1 = "moe";
        port1 = "LVDS-1";
        mode1 = "1280x800";
        pos1 = "0x0";
        monitor2 = "dell4k";
        port2 = "DP-1";
        mode2 = "1920x1080";
        pos2 = "1280x0";
      };

      mako = mkProfile {
        monitor = "mako";
        port = "eDP-1";
        mode = "2560x1600";
      };

      mako-dell1 = mkDualProfile {
        monitor1 = "mako";
        port1 = "eDP-1";
        mode1 = "2560x1600";
        pos1 = "0x0";
        monitor2 = "dell4k";
        port2 = "DP-1";
        mode2 = "3840x2160_30.00";
        pos2 = "2560x0";
      };
      mako-dell2 = mkDualProfile {
        monitor1 = "mako";
        port1 = "eDP-1";
        mode1 = "2560x1600";
        pos1 = "0x0";
        monitor2 = "dell4k";
        port2 = "DP-2";
        mode2 = "3840x2160_30.00";
        pos2 = "2560x0";
      };
    };
  };
}
