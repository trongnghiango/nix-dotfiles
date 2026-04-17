{ pkgs, ... }:

let
  # Định nghĩa phiên bản để dễ cập nhật sau này
  obsidianVersion = "1.11.5";

  # Tạo gói Obsidian từ AppImage
  obsidian-app = pkgs.appimageTools.wrapType2 {
    pname = "obsidian";
    version = obsidianVersion;

    src = pkgs.fetchurl {
      url = "https://github.com/obsidianmd/obsidian-releases/releases/download/v${obsidianVersion}/Obsidian-${obsidianVersion}.AppImage";
      # THAY MÃ HASH BẠN VỪA LẤY ĐƯỢC VÀO ĐÂY
      # sha256 = "1ipj0dhj2l8yv3fivffhd4r8xvk0ix3gs71wk1c5clhzk4bf376h";

      # THÀNH DÒNG NÀY (Định dạng SRI):
      hash = "sha256-0JzhFpkfUlZYmDwc/UaPYO6OMmnQuR3d2B5RIWED8sY=";

    };

    # Các thư viện bổ sung để Obsidian hoạt động ổn định trên NixOS
    extraPkgs =
      pkgs: with pkgs; [
        libsecret
        zlib
        dbus-glib
      ];
  };
in
{
  # 1. Cài đặt vào User Packages
  home.packages = [
    obsidian-app
  ];

  # 2. Tạo Launcher cho Rofi/Dmenu
  xdg.desktopEntries = {
    "obsidian" = {
      name = "Obsidian";
      exec = "${obsidian-app}/bin/obsidian %u";
      icon = "obsidian"; # NixOS thường tự nhận icon nếu có theme Papirus
      comment = "Knowledge base of markdown files";
      categories = [
        "Office"
        "Utility"
      ];
      mimeType = [ "x-scheme-handler/obsidian" ];
    };
  };
}
