{ config, pkgs, inputs, ... }:

let
  # Script copy config don gian (dung chung)
  copyConfig = ''
    echo ">>> Dang o thu muc: $(pwd)"
    ls -la
    if [ ! -f config.h ] && [ -f config.def.h ]; then
      echo ">>> Copy config.def.h -> config.h"
      cp config.def.h config.h
    fi
  '';

  commonDeps = with pkgs; [
    pkg-config gnumake gcc
    xorg.libX11 xorg.libXft xorg.libXinerama
    xorg.libXres xorg.libxcb xorg.xcbutil
    yajl imlib2 harfbuzz
    ncurses
  ];
in
{
  nixpkgs.overlays = [
    (final: prev: {

      # --- DWM ---
      dwm = pkgs.stdenv.mkDerivation {
        pname = "dwm-custom"; version = "6.5"; src = inputs.dwm-src;
        nativeBuildInputs = [ pkgs.pkg-config pkgs.ncurses ];
        buildInputs = commonDeps;
        
        # FIX: Chui vao thu muc dwm truoc
        preBuild = ''
          cd dwm
          ${copyConfig}
        '';
        
        # Fix: make install se cai vao $out
        makeFlags = [ "PREFIX=$(out)" ];
      };

      # --- ST ---
      st = pkgs.stdenv.mkDerivation {
        pname = "st-custom"; version = "0.9"; src = inputs.st-src;
        nativeBuildInputs = [ pkgs.pkg-config pkgs.ncurses ];
        buildInputs = commonDeps;
        
        # FIX: Chui vao thu muc st truoc
        preBuild = ''
          cd st
          ${copyConfig}
        '';
        
        # Fix: Tao thu muc terminfo va chi dinh install vao do
        preInstall = "mkdir -p $out/share/terminfo";
        makeFlags = [ "PREFIX=$(out)" "TERMINFO=$(out)/share/terminfo" ];
      };

      # --- DMENU ---
      dmenu = pkgs.stdenv.mkDerivation {
        pname = "dmenu-custom"; version = "5.3"; src = inputs.dmenu-src;
        nativeBuildInputs = [ pkgs.pkg-config pkgs.ncurses ];
        buildInputs = commonDeps;
        
        # FIX: Chui vao thu muc dmenu truoc
        preBuild = ''
          cd dmenu
          ${copyConfig}
        '';
        
        makeFlags = [ "PREFIX=$(out)" ];
      };

      # --- DWMBLOCKS ---
      dwmblocks = pkgs.stdenv.mkDerivation {
        pname = "dwmblocks-async"; version = "custom"; src = inputs.dwmblocks-src;
        nativeBuildInputs = [ pkgs.pkg-config ]; buildInputs = commonDeps;
        
        # FIX: Chui vao thu muc dwmblocks truoc
        preBuild = ''
          cd dwmblocks
          ${copyConfig}
        '';
        
        makeFlags = [ "PREFIX=$(out)" ];
      };

    })
  ];

  environment.systemPackages = with pkgs; [ st dmenu dwmblocks xorg.xsetroot xwallpaper picom libnotify dunst bc jq ];
  services.xserver = { enable = true; xkb.layout = "us"; displayManager.startx.enable = true; windowManager.dwm.enable = true; };
  hardware.graphics = { enable = true; extraPackages = with pkgs; [ intel-vaapi-driver libvdpau-va-gl ]; };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "i965"; };
  services.gvfs.enable = true; services.udisks2.enable = true; services.libinput.enable = true; programs.dconf.enable = true;
}

