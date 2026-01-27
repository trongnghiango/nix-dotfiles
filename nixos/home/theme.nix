{ pkgs, config, scale, ... }: # Nhận biến scale truyền từ flake.nix

let
  # --- HÀM TÍNH TOÁN SIZE DỰA TRÊN TỶ LỆ MÀN HÌNH ---
  # builtins.floor để làm tròn xuống số nguyên
  multiply = size: builtins.floor (size * scale);

  # ========================================================================
  # 1. BẢNG MÀU "YUKINORD-MOCHA" (TRỨ TRỰC TỪ NEOVIM)
  # ========================================================================
  palette = {
    # Base Backgrounds
    bg      = "#1B212B"; # Yukinord bg0 (Editor background)
    mantle  = "#14171d"; # Panel background
    crust   = "#0f1115"; # Darker background

    # Foreground & Text
    fg      = "#eceff4"; # Yukinord fg0 (Bright text)
    subtext = "#d8dee9"; # Editor foreground
    comment = "#8d929c"; # Comments / Overlay2

    # Accent Colors (Yukinord Palette)
    red     = "#bf616a"; # Yukinord Red
    orange  = "#d08770"; # Yukinord Orange
    yellow  = "#ebcb8b"; # Yukinord Yellow
    green   = "#a3be8c"; # Yukinord Green
    blue    = "#81a1c1"; # Yukinord Blue
    purple  = "#b48ead"; # Yukinord Purple
    cyan    = "#88c0d0"; # Yukinord Cyan (Sky)
    teal    = "#8fbcbb"; # Yukinord Teal

    # UI Elements
    border    = "#3b4252"; # Surface0 (Borders)
    selection = "#5e81ac"; # Sapphire (Selection)
    statusbar = "#2B3442"; # Thanh trạng thái Yukinord

    alpha = "0.8"; # Độ trong suốt cho ST
  };

  # --- CẤU HÌNH FONT (Tự động co giãn) ---
  fontConfig = {
    name = "Inter";
    package = pkgs.inter;
    size = multiply 11; # X230: 11 | 4K: 16-17
  };

  # --- CẤU HÌNH CURSOR (Tự động co giãn) ---
  cursorConfig = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = multiply 24; # X230: 24 | 4K: 36
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
    "*.alpha"      = palette.alpha;
    "st.alpha"     = palette.alpha;

    # Normal Colors
    "*.color0" = palette.bg;      # Black
    "*.color1" = palette.red;     # Red
    "*.color2" = palette.green;   # Green
    "*.color3" = palette.yellow;  # Yellow
    "*.color4" = palette.blue;    # Blue
    "*.color5" = palette.purple;  # Magenta
    "*.color6" = palette.cyan;    # Cyan
    "*.color7" = palette.fg;      # White

    # Bright Colors
    "*.color8"  = palette.comment; # Bright Black
    "*.color9"  = palette.red;     # Bright Red
    "*.color10" = palette.green;   # Bright Green
    "*.color11" = palette.yellow;  # Bright Yellow
    "*.color12" = palette.selection; # Bright Blue
    "*.color13" = palette.purple;  # Bright Magenta
    "*.color14" = palette.teal;    # Bright Cyan
    "*.color15" = palette.fg;      # Bright White

    # DWM Specific
    "dwm.normbgcolor"     = palette.bg;
    "dwm.normfgcolor"     = palette.subtext;
    "dwm.normbordercolor" = palette.border;

    "dwm.selbgcolor"      = palette.statusbar;
    "dwm.selfgcolor"      = palette.fg;
    "dwm.selbordercolor"  = palette.red;

    # Cursor & Font Scale (Đặc biệt quan trọng cho màn hình độ phân giải cao)
    "Xcursor.size"  = cursorConfig.size;
    "Xcursor.theme" = cursorConfig.name;
    "*.font"        = "${fontConfig.name}:size=${toString fontConfig.size}";
  };

  # ========================================================================
  # 3. GIAO DIỆN GTK & QT (DÙNG THEME NORDIC)
  # ========================================================================
  gtk = {
    enable = true;

    font = {
      name = fontConfig.name;
      size = fontConfig.size;
      package = fontConfig.package;
    };

    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    # Cấu hình file .gtkrc-2.0 (cho app cũ)
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    
    # Ép GTK3/4 sử dụng dark mode
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  # Ép QT đồng bộ hoàn toàn với GTK
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };

  # ========================================================================
  # 4. CON TRỎ CHUỘT (TỰ ĐỘNG FIX CHO X11)
  # ========================================================================
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = cursorConfig.name;
    package = cursorConfig.package;
    size = cursorConfig.size;
  };

  # Đồng bộ biến môi trường Theme (Dành cho các script shell)
  home.sessionVariables = {
    GTK_THEME = "Nordic";
    XCURSOR_SIZE = "${toString cursorConfig.size}";
    XCURSOR_THEME = "${cursorConfig.name}";
  };
}
