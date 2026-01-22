{
  config,
  pkgs,
  inputs,
  ...
}:

{
  nixpkgs.overlays = [
    (final: prev: {

      # =========================================================
      # 1. CUSTOM DWM
      # =========================================================
      dwm = prev.dwm.overrideAttrs (oldAttrs: {
        pname = "dwm-custom";
        src = inputs.dwm-src;
        sourceRoot = "dwm";

        nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ pkgs.pkg-config ];

        buildInputs =
          oldAttrs.buildInputs
          ++ (with pkgs; [
            yajl
            imlib2
            xorg.libX11
            xorg.libXft
            xorg.libXinerama
            xorg.libxcb
            xorg.xcbutil
            xorg.libXres
          ]);

        preBuild = ''
          if [ ! -f config.h ]; then cp config.def.h config.h; fi
        '';

        # --- FIX LỖI "Permission denied /homeless-shelter" ---
        # Ép make cài vào thư mục Nix Store thay vì ~/.local
        makeFlags = [ "PREFIX=$(out)" ];
      });

      # =========================================================
      # 2. CUSTOM ST
      # =========================================================
      st = prev.st.overrideAttrs (oldAttrs: {
        pname = "st-custom";
        src = inputs.st-src;
        sourceRoot = "st";

        nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ pkgs.pkg-config ];

        buildInputs =
          oldAttrs.buildInputs
          ++ (with pkgs; [
            harfbuzz
            xorg.libX11
            xorg.libXft
          ]);

        preBuild = ''
          if [ ! -f config.h ]; then cp config.def.h config.h; fi
        '';

        # --- FIX LỖI TƯƠNG TỰ CHO ST ---
        makeFlags = [ "PREFIX=$(out)" ];
      });

      # =========================================================
      # 3. CUSTOM DMENU
      # =========================================================
      dmenu = prev.dmenu.overrideAttrs (oldAttrs: {
        pname = "dmenu-custom";
        src = inputs.dmenu-src;
        sourceRoot = "dmenu";

        nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ pkgs.pkg-config ];

        buildInputs =
          oldAttrs.buildInputs
          ++ (with pkgs; [
            xorg.libX11
            xorg.libXft
            xorg.libXinerama
            xorg.libXres
          ]);

        preBuild = ''
          if [ ! -f config.h ]; then cp config.def.h config.h; fi
        '';

        # --- FIX LỖI TƯƠNG TỰ CHO DMENU ---
        makeFlags = [ "PREFIX=$(out)" ];
      });

      # =========================================================
      # 4. CUSTOM DWMBLOCKS (Async)
      # =========================================================
      dwmblocks = pkgs.stdenv.mkDerivation {
        pname = "dwmblocks-async";
        version = "custom";
        src = inputs.dwmblocks-src;
        sourceRoot = "dwmblocks";

        nativeBuildInputs = [ pkgs.pkg-config ];

        buildInputs = with pkgs; [
          xorg.libX11
          xorg.libXft
          xorg.libXinerama
          xorg.libxcb
          xorg.xcbutil
        ];

        preBuild = ''
          mkdir -p build
          if [ ! -f config.h ]; then cp config.def.h config.h; fi
        '';

        # Cái này đã có từ trước và nó hoạt động tốt
        makeFlags = [ "PREFIX=$(out)" ];
      };

    })
  ];

  # =========================================================
  # System Packages
  # =========================================================
  environment.systemPackages = with pkgs; [
    st
    dmenu
    dwmblocks
    xorg.xsetroot
    xwallpaper
    picom
    libnotify
    dunst
    bc
    jq
  ];

  services.xserver = {
    enable = true;
    xkb.layout = "us";
    displayManager.startx.enable = true;
    windowManager.dwm.enable = true;
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      # intel-media-driver # -> intel doi moi
      # X230 (Ivy Bridge) CẦN cái này
      intel-vaapi-driver

      # Hỗ trợ OpenGL/Vulkan
      libvdpau-va-gl
      #libva-vdpau-driver
    ];
  };

  # Ép hệ thống dùng driver i965 (quan trọng cho X230)
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "i965";
  };

  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.libinput.enable = true;
  programs.dconf.enable = true;
}
