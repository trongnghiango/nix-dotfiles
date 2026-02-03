{ pkgs, gpuType, ... }:

let
  # Tạo gói từ file .deb chính chủ
  min-browser-pkg = pkgs.stdenv.mkDerivation rec {
    pname = "min-browser";
    version = "1.35.3";

    src = pkgs.fetchurl {
      # https://github.com/minbrowser/min/releases/download/v1.35.3/min-1.35.3-amd64.deb
      url = "https://github.com/minbrowser/min/releases/download/v${version}/min-${version}-amd64.deb";
      # MÃ HASH CHUẨN (Tao đã tính toán lại theo định dạng SRI)
      hash = "sha256-2WR/rjJD66ue5GuE/sl1G8z6EG9YLhphJoVeepXwwH8=";
      # LƯU Ý: Nếu build báo mismatch, lấy cái mã "got" dán vào đây là xong.
    };

    # Các công cụ hỗ trợ build: giải nén deb, vá thư viện, tạo wrapper
    nativeBuildInputs = with pkgs; [
      dpkg
      autoPatchelfHook
      makeWrapper
    ];

    # SỬA Ở ĐÂY: Thêm 'with xorg;' để Nix thấy được các thư viện libX...
    buildInputs =
      with pkgs;
      [
        alsa-lib
        at-spi2-atk
        at-spi2-core
        atk
        cairo
        cups
        dbus
        expat
        fontconfig
        freetype
        gdk-pixbuf
        glib
        gtk3
        nspr
        nss
        pango
        systemd
        libdrm
        libglvnd
        libxshmfence
        mesa
      ]
      ++ (with pkgs.xorg; [
        libX11
        libXcomposite
        libXcursor
        libXdamage
        libXext
        libXfixes
        libXi
        libXrandr
        libXrender
        libXScrnSaver
        libXtst
      ]);

    unpackPhase = "dpkg-deb -x $src .";

    installPhase = ''
      mkdir -p $out/bin $out/share/min
      cp -r opt/Min/* $out/share/min/

      makeWrapper $out/share/min/min $out/bin/min-browser \
        --add-flags "${if gpuType == "virtio" then "--disable-gpu" else ""}" \
        --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath buildInputs}"
        
      mkdir -p $out/share/icons/hicolor/scalable/apps
      cp usr/share/icons/hicolor/scalable/apps/min.svg $out/share/icons/hicolor/scalable/apps/ || true
    '';
  };
in
{
  home.packages = [ min-browser-pkg ];

  xdg.desktopEntries."min" = {
    name = "Min Browser";
    exec = "min-browser %U";
    icon = "min";
    categories = [
      "Network"
      "WebBrowser"
    ];
    mimeType = [
      "text/html"
      "text/xml"
      "application/xhtml+xml"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
    ];
  };
}
