{ pkgs, ... }:

let
  # ========================================================================
  # 1. ĐỊNH NGHĨA BIẾN (CONSTANTS)
  # Sửa ở đây sẽ thay đổi toàn bộ hệ thống -> Dễ bảo trì (Clean Code)
  # ========================================================================
  
  # Font chữ cho giao diện (UI)
  fontConfig = {
    name = "Inter";
    package = pkgs.inter;
    size = 11;
  };

  # Cursor (Con trỏ chuột) - Chọn loại hiện đại hơn Adwaita
  cursorConfig = {
    name = "Bibata-Modern-Ice"; # Hoặc "Adwaita" nếu bạn thích cổ điển
    package = pkgs.bibata-cursors;
    size = 24;
  };

  # GTK Theme
  gtkTheme = {
    name = "Arc-Dark";
    package = pkgs.arc-theme;
  };

  # Icon Theme
  iconTheme = {
    name = "Papirus-Dark";
    package = pkgs.papirus-icon-theme;
  };

in
{
  # ========================================================================
  # 2. CẤU HÌNH CON TRỎ CHUỘT (POINTER CURSOR)
  # home.pointerCursor mạnh hơn gtk.cursorTheme vì nó tự fix lỗi cho X11
  # ========================================================================
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true; # Quan trọng cho DWM
    name = cursorConfig.name;
    package = cursorConfig.package;
    size = cursorConfig.size;
  };

  # ========================================================================
  # 3. CẤU HÌNH GTK (Giao diện chính)
  # ========================================================================
  gtk = {
    enable = true;
    
    font = {
      name = fontConfig.name;
      size = fontConfig.size;
      package = fontConfig.package;
    };

    theme = {
      name = gtkTheme.name;
      package = gtkTheme.package;
    };

    iconTheme = {
      name = iconTheme.name;
      package = iconTheme.package;
    };

    # Cấu hình file .gtkrc-2.0 (cho app cũ)
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };

  # ========================================================================
  # 4. CẤU HÌNH QT (Để app QT trông giống GTK)
  # Đây là bước "Pro" mà nhiều người quên
  # ========================================================================
  qt = {
    enable = true;
    platformTheme.name = "gtk"; # Ép QT dùng theme của GTK
    style.name = "gtk2";
  };

  # ========================================================================
  # 5. CẤU HÌNH XRESOURCES (Cho các app X11 cũ, nếu cần)
  # ========================================================================
  xresources.properties = {
    "Xcursor.size" = cursorConfig.size;
    "Xcursor.theme" = cursorConfig.name;
  };
}
