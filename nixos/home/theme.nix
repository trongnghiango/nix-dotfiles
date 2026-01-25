{ pkgs, config, ... }:

let
  # ========================================================================
  # 1. SOURCE OF TRUTH (BẢNG MÀU TRÍCH XUẤT TỪ CONFIG.H CỦA BẠN)
  # ========================================================================
  palette = {
    # Lấy từ ST config.h (Gruvbox)
    bg = "#282828";
    fg = "#ebdbb2";
    alpha = "0.8";

    # Accent color lấy từ DWM selbordercolor
    accent = "#BF616A";

    # 16 Colors chuẩn từ ST của bạn
    color0 = "#282828"; # Black
    color1 = "#cc241d"; # Red
    color2 = "#98971a"; # Green
    color3 = "#d79921"; # Yellow
    color4 = "#458588"; # Blue
    color5 = "#b16286"; # Magenta
    color6 = "#689d6a"; # Cyan
    color7 = "#a89984"; # White
    color8 = "#928374"; # Bright Black
    color9 = "#fb4934"; # Bright Red
    color10 = "#b8bb26"; # Bright Green
    color11 = "#fabd2f"; # Bright Yellow
    color12 = "#83a598"; # Bright Blue
    color13 = "#d3869b"; # Bright Magenta
    color14 = "#8ec07c"; # Bright Cyan
    color15 = "#ebdbb2"; # Bright White
  };

  fontConfig = {
    name = "Inter";
    package = pkgs.inter;
    size = 11;
  };

  cursorConfig = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
  };

in
{
  # ========================================================================
  # 2. XRESOURCES (ĐỒNG BỘ TRIỆT ĐỂ CHO ST VÀ DWM)
  # Vì DWM của bạn có phím tắt XK_F5 xrdb, nó sẽ đọc trực tiếp từ đây.
  # ========================================================================
  xresources.properties = {
    # Chung cho Terminal (ST đọc các biến này)
    "*.background" = palette.bg;
    "*.foreground" = palette.fg;
    "*.alpha" = palette.alpha;
    "st.alpha" = palette.alpha;

    # 16 Colors cho ST
    "*.color0" = palette.color0;
    "*.color1" = palette.color1;
    "*.color2" = palette.color2;
    "*.color3" = palette.color3;
    "*.color4" = palette.color4;
    "*.color5" = palette.color5;
    "*.color6" = palette.color6;
    "*.color7" = palette.color7;
    "*.color8" = palette.color8;
    "*.color9" = palette.color9;
    "*.color10" = palette.color10;
    "*.color11" = palette.color11;
    "*.color12" = palette.color12;
    "*.color13" = palette.color13;
    "*.color14" = palette.color14;
    "*.color15" = palette.color15;

    # Biến riêng cho DWM (Nếu bản build DWM của bạn dùng xrdb patch)
    "dwm.normbgcolor" = palette.bg;
    "dwm.normfgcolor" = palette.fg;
    "dwm.selbgcolor" = palette.color4; # Blue làm màu highlight
    "dwm.selfgcolor" = palette.bg;
    "dwm.selbordercolor" = palette.accent;
    "dwm.normbordercolor" = palette.color8;

    # Mouse
    "Xcursor.size" = cursorConfig.size;
    "Xcursor.theme" = cursorConfig.name;
  };

  # ========================================================================
  # 3. GTK & QT (ĐỒNG BỘ THEME VỚI MÀU CỦA ST)
  # ========================================================================
  gtk = {
    enable = true;
    font = {
      name = fontConfig.name;
      size = fontConfig.size;
      package = fontConfig.package;
    };
    theme = {
      # Đổi sang Gruvbox-Dark để đồng bộ hoàn toàn với ST của bạn
      name = "Gruvbox-Dark-B";
      package = pkgs.gruvbox-gtk-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = cursorConfig.name;
    package = cursorConfig.package;
    size = cursorConfig.size;
  };
}
