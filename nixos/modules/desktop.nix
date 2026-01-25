{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

let
  # =========================
  # Build dependencies cho suckless
  # =========================
  sucklessDeps = with pkgs; [
    pkg-config
    gnumake
    gcc
    ncurses

    xorg.libX11
    xorg.libXft
    xorg.libXinerama
    xorg.libXres
    xorg.libxcb
    xorg.xcbutil
    yajl
    imlib2
    harfbuzz
  ];

  copyConfig = ''
    if [ ! -f config.h ] && [ -f config.def.h ]; then
      cp config.def.h config.h
    fi
  '';
in
{
  # =========================
  # Overlay: suckless custom
  # =========================
  nixpkgs.overlays = [
    (final: prev: {
      dwm = prev.stdenv.mkDerivation {
        pname = "dwm-custom";
        version = "6.5";
        src = inputs.dwm-src;

        nativeBuildInputs = [ prev.pkg-config ];
        buildInputs = sucklessDeps;

        preBuild = copyConfig;
        makeFlags = [ "PREFIX=$(out)" ];
      };

      st = prev.stdenv.mkDerivation {
        pname = "st-custom";
        version = "0.9";
        src = inputs.st-src;

        nativeBuildInputs = [ prev.pkg-config ];
        buildInputs = sucklessDeps;

        preBuild = copyConfig;
        preInstall = "mkdir -p $out/share/terminfo";
        makeFlags = [
          "PREFIX=$(out)"
          "TERMINFO=$(out)/share/terminfo"
        ];
      };

      dmenu = prev.stdenv.mkDerivation {
        pname = "dmenu-custom";
        version = "5.3";
        src = inputs.dmenu-src;

        nativeBuildInputs = [ prev.pkg-config ];
        buildInputs = sucklessDeps;

        preBuild = copyConfig;
        makeFlags = [ "PREFIX=$(out)" ];
      };

      dwmblocks = prev.stdenv.mkDerivation {
        pname = "dwmblocks";
        version = "custom";
        src = inputs.dwmblocks-src;

        nativeBuildInputs = [ prev.pkg-config ];
        buildInputs = sucklessDeps;

        preBuild = copyConfig;
        makeFlags = [ "PREFIX=$(out)" ];
      };
    })
  ];

  # =========================
  # System packages (tối thiểu)
  # =========================
  environment.systemPackages = with pkgs; [
    dwm
    st
    dmenu
    dwmblocks

    xorg.xrandr
    xorg.xset
    xclip
    feh
  ];

  # =========================
  # XORG + STARTX (THUẦN)
  # =========================
  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;

  # Đăng ký dwm đúng chuẩn NixOS
  services.xserver.windowManager.dwm.enable = true;

  # Không desktop manager
  services.xserver.desktopManager.xterm.enable = false;

  # =========================
  # INPUT
  # =========================
  services.libinput.enable = true;

  # =========================
  # GRAPHICS (tự động theo host)
  # =========================
  services.xserver.videoDrivers =
    if config.hardware.profile.gpu == "intel" then
      [ "intel" ]
    else if config.hardware.profile.gpu == "virtio" then
      [ "virtio" ]
    else if config.hardware.profile.gpu == "nvidia-legacy" then
      [ "nvidiaLegacy470" ]
    else
      [ ];

  hardware.graphics.enable = config.hardware.profile.opengl;

  # =========================
  # VM niceties
  # =========================
  services.spice-vdagentd.enable = config.hardware.profile.isVirtual;
  services.qemuGuest.enable = config.hardware.profile.isVirtual;

  # =========================
  # GTK apps (nhẹ, cần thiết)
  # =========================
  programs.dconf.enable = true;

  # =========================
  # Disk & removable (optional)
  # =========================
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}
