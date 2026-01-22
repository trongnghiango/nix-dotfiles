{ config, pkgs, inputs, ... }:

let
  # 1. Script "Thần thánh": Tự tìm Makefile, tự cd, tự tạo config
  autoBuildScript = ''
    echo ">>> [AUTO] Dang tim Makefile..."
    if [ ! -f Makefile ]; then
      # Tim file Makefile bat ke no nam o dau (sau 2 cap thu muc)
      TARGET=$(find . -maxdepth 2 -name Makefile | head -n 1)
      if [ -n "$TARGET" ]; then
        DIR=$(dirname "$TARGET")
        echo ">>> [AUTO] Thay Makefile o: $DIR. Dang chui vao..."
        cd "$DIR"
      fi
    fi

    echo ">>> [AUTO] Chuan bi moi truong..."
    mkdir -p build  # Fix loi dwmblocks
    if [ ! -f config.h ] && [ -f config.def.h ]; then
      echo ">>> [AUTO] Tao config.h tu config.def.h"
      cp config.def.h config.h
    fi
  '';

  # 2. Bộ giáp "Full Option": Nhet het thu vien vao
  # Khong quan tam la dmenu hay st, cu nhet du vao la khong bao gio loi thieu
  commonDeps = with pkgs; [
    pkg-config
    gnumake
    gcc
    xorg.libX11
    xorg.libXft
    xorg.libXinerama
    xorg.libXres      # Fix loi dmenu/xrdb
    xorg.libxcb       # Fix loi dwmblocks/swallow
    xorg.xcbutil
    yajl              # Fix loi dwm-ipc
    imlib2            # Fix loi dwm-icon
    harfbuzz          # Fix loi st-ligatures
  ];

in
{
  nixpkgs.overlays = [
    (final: prev: {
      
      # DWM
      dwm = pkgs.stdenv.mkDerivation {
        pname = "dwm-custom";
        version = "6.5";
        src = inputs.dwm-src;
        nativeBuildInputs = [ pkgs.pkg-config ];
        buildInputs = commonDeps; # Nhet full thu vien
        preBuild = autoBuildScript; # Tu dong fix loi
        makeFlags = [ "PREFIX=$(out)" ];
      };

      # ST
      st = pkgs.stdenv.mkDerivation {
        pname = "st-custom";
        version = "0.9";
        src = inputs.st-src;
        nativeBuildInputs = [ pkgs.pkg-config ];
        buildInputs = commonDeps;
        preBuild = autoBuildScript;
        makeFlags = [ "PREFIX=$(out)" ];
      };

      # DMENU (Thang dang bi loi)
      dmenu = pkgs.stdenv.mkDerivation {
        pname = "dmenu-custom";
        version = "5.3";
        src = inputs.dmenu-src;
        nativeBuildInputs = [ pkgs.pkg-config ];
        buildInputs = commonDeps; # Co xcb roi, het loi
        preBuild = autoBuildScript;
        makeFlags = [ "PREFIX=$(out)" ];
      };

      # DWMBLOCKS
      dwmblocks = pkgs.stdenv.mkDerivation {
        pname = "dwmblocks-async";
        version = "custom";
        src = inputs.dwmblocks-src;
        nativeBuildInputs = [ pkgs.pkg-config ];
        buildInputs = commonDeps;
        preBuild = autoBuildScript;
        makeFlags = [ "PREFIX=$(out)" ];
      };

    })
  ];

  # Phan con lai giu nguyen
  environment.systemPackages = with pkgs; [
    st dmenu dwmblocks
    xorg.xsetroot xwallpaper picom libnotify dunst bc jq
  ];

  services.xserver = {
    enable = true;
    xkb.layout = "us";
    displayManager.startx.enable = true;
    windowManager.dwm.enable = true;
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ intel-vaapi-driver libvdpau-va-gl ];
  };

  environment.sessionVariables = { LIBVA_DRIVER_NAME = "i965"; };
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.libinput.enable = true;
  programs.dconf.enable = true;
}

