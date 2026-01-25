{
  config,
  pkgs,
  inputs,
  ...
}:

let
  # Script copy config đơn giản
  copyConfig = ''
    if [ ! -f config.h ] && [ -f config.def.h ]; then
      cp config.def.h config.h
    fi
  '';

  # Dependencies để build Suckless tools
  sucklessDeps = with pkgs; [
    pkg-config
    gnumake
    gcc
    xorg.libX11
    xorg.libXft
    xorg.libXinerama
    xorg.libXres
    xorg.libxcb
    xorg.xcbutil
    yajl
    imlib2
    harfbuzz
    ncurses
  ];
in
{
  # --- Overlay: Build DWM/ST từ source ---
  nixpkgs.overlays = [
    (final: prev: {
      dwm = pkgs.stdenv.mkDerivation {
        pname = "dwm-custom";
        version = "6.5";
        src = inputs.dwm-src;
        nativeBuildInputs = [
          pkgs.pkg-config
          pkgs.ncurses
        ];
        buildInputs = sucklessDeps;
        preBuild = copyConfig;
        makeFlags = [ "PREFIX=$(out)" ];
      };

      st = pkgs.stdenv.mkDerivation {
        pname = "st-custom";
        version = "0.9";
        src = inputs.st-src;
        nativeBuildInputs = [
          pkgs.pkg-config
          pkgs.ncurses
        ];
        buildInputs = sucklessDeps;
        preBuild = copyConfig;
        preInstall = "mkdir -p $out/share/terminfo";
        makeFlags = [
          "PREFIX=$(out)"
          "TERMINFO=$(out)/share/terminfo"
        ];
      };

      dmenu = pkgs.stdenv.mkDerivation {
        pname = "dmenu-custom";
        version = "5.3";
        src = inputs.dmenu-src;
        nativeBuildInputs = [
          pkgs.pkg-config
          pkgs.ncurses
        ];
        buildInputs = sucklessDeps;
        preBuild = copyConfig;
        makeFlags = [ "PREFIX=$(out)" ];
      };

      dwmblocks = pkgs.stdenv.mkDerivation {
        pname = "dwmblocks-async";
        version = "custom";
        src = inputs.dwmblocks-src;
        nativeBuildInputs = [ pkgs.pkg-config ];
        buildInputs = sucklessDeps;
        preBuild = copyConfig;
        makeFlags = [ "PREFIX=$(out)" ];
      };
    })
  ];

  # Chỉ cài đúng 4 món này vào hệ thống
  environment.systemPackages = with pkgs; [
    dwm
    st
    dmenu
    dwmblocks
  ];

  # --- X11 Configuration ---
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;

    # THAY ĐỔI Ở ĐÂY: Trỏ windowManager vào gói custom của bạn
    windowManager.session = [
      {
        name = "dwm";
        start = ''
          ${pkgs.dwm}/bin/dwm &
          wait $!
        '';
      }
    ];
  };

  # --- Graphics & Drivers ---
  # hardware.graphics = {
  #   enable = true;
  #   extraPackages = with pkgs; [
  #     intel-vaapi-driver
  #     libvdpau-va-gl
  #   ];
  # };

  # using for virt-machine
  services.xserver.videoDrivers = [ "virtio" ];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "i965";
  };

  # --- System Services ---
  services.gvfs.enable = true; # Mount ổ đĩa, USB
  services.udisks2.enable = true; # Quản lý ổ đĩa
  services.libinput.enable = true; # Touchpad
  programs.dconf.enable = true; # Cần cho GTK apps
}
