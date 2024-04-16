{ pkgs, ... }:
{
  # i3 related options
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

  services.displayManager.defaultSession = "none+i3";

  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
      runXdgAutostartIfNone = true;
    };
    displayManager = {
      startx.enable = true;
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        i3lock
        maim
        xclip
        xfce.thunar
        i3wsr
      ];
    };

    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
    };
  };
}
