{ pkgs, config, ... }:

let
  # ========================================================================
  # 1. BẢNG MÀU "YUKINORD-MOCHA" (TRÍCH XUẤT TỪ NEOVIM CONFIG)
  # Đây là nguồn chân lý duy nhất cho toàn bộ hệ thống.
  # ========================================================================
  palette = {
    # Base Backgrounds
    bg = "#1B212B"; # Yukinord bg0 (Editor background)
    mantle = "#14171d"; # Panel background
    crust = "#0f1115"; # Darker background

    # Foreground & Text
    fg = "#eceff4"; # Yukinord fg0 (Bright text)
    subtext = "#d8dee9"; # Editor foreground
    comment = "#8d929c"; # Comments / Overlay2

    # Accent Colors (Yukinord Palette)
    red = "#bf616a"; # Yukinord Red (Accent chính của bạn)
    orange = "#d08770"; # Yukinord Orange
    yellow = "#ebcb8b"; # Yukinord Yellow
    green = "#a3be8c"; # Yukinord Green
    blue = "#81a1c1"; # Yukinord Blue
    purple = "#b48ead"; # Yukinord Purple
    cyan = "#88c0d0"; # Yukinord Cyan (Sky)
    teal = "#8fbcbb"; # Yukinord Teal

    # UI Elements
    border = "#3b4252"; # Surface0 (Borders)
    selection = "#5e81ac"; # Sapphire (Selection)
    statusbar = "#2B3442"; # Màu thanh trạng thái Yukinord

    alpha = "0.8"; # Độ trong suốt cho ST
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
  # 2. XRESOURCES (ĐỒNG BỘ CHO ST & DWM)
  # ========================================================================
  xresources.properties = {
    # Terminal Colors (Khớp 100% với Neovim)
    "*.background" = palette.bg;
    "*.foreground" = palette.fg;
    "*.alpha" = palette.alpha;
    "st.alpha" = palette.alpha;

    # Normal Colors
    "*.color0" = palette.bg; # Black
    "*.color1" = palette.red; # Red
    "*.color2" = palette.green; # Green
    "*.color3" = palette.yellow; # Yellow
    "*.color4" = palette.blue; # Blue
    "*.color5" = palette.purple; # Magenta
    "*.color6" = palette.cyan; # Cyan
    "*.color7" = palette.fg; # White

    # Bright Colors
    "*.color8" = palette.comment; # Bright Black
    "*.color9" = palette.red; # Bright Red
    "*.color10" = palette.green; # Bright Green
    "*.color11" = palette.yellow; # Bright Yellow
    "*.color12" = palette.selection; # Bright Blue
    "*.color13" = palette.purple; # Bright Magenta
    "*.color14" = palette.teal; # Bright Cyan
    "*.color15" = palette.fg; # Bright White

    # DWM Specific (Dành cho bản build có xrdb patch)
    "dwm.normbgcolor" = palette.bg;
    "dwm.normfgcolor" = palette.subtext;
    "dwm.normbordercolor" = palette.border;

    "dwm.selbgcolor" = palette.statusbar;
    "dwm.selfgcolor" = palette.fg;
    "dwm.selbordercolor" = palette.red; # Accent Red từ Yukinord

    # Cursor
    "Xcursor.size" = cursorConfig.size;
    "Xcursor.theme" = cursorConfig.name;
  };

  # ========================================================================
  # 3. GIAO DIỆN GTK & QT (THEME NORDIC)
  # Vì Yukinord dựa trên Nord, bộ theme Nordic là sự kết hợp hoàn hảo nhất.
  # ========================================================================
  gtk = {
    enable = true;
    font = {
      name = fontConfig.name;
      size = fontConfig.size;
      package = fontConfig.package;
    };
    theme = {
      name = "Nordic"; # Theme chuẩn nhất cho palette này
      package = pkgs.nordic;
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
