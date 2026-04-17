{
  pkgs,
  config,
  scale,
  ...
}: # Nhận biến scale truyền từ flake.nix

let
  # --- HÀM TÍNH TOÁN SIZE DỰA TRÊN TỶ LỆ MÀN HÌNH ---
  multiply = size: builtins.floor (size * scale);

  # ========================================================================
  # 1. BẢNG MÀU "YUKINORD-MOCHA" (GIỮ NGUYÊN 100% TỪ BẢN GỐC)
  # ========================================================================
  palette = {
    bg = "#1B212B"; # Yukinord bg0 (Editor background)
    mantle = "#14171d"; # Panel background
    crust = "#0f1115"; # Darker background
    fg = "#eceff4"; # Yukinord fg0 (Bright text)
    subtext = "#d8dee9"; # Editor foreground
    comment = "#8d929c"; # Comments / Overlay2
    red = "#bf616a"; # Yukinord Red
    orange = "#d08770"; # Yukinord Orange
    yellow = "#ebcb8b"; # Yukinord Yellow
    green = "#a3be8c"; # Yukinord Green
    blue = "#81a1c1"; # Yukinord Blue
    purple = "#b48ead"; # Yukinord Purple
    cyan = "#88c0d0"; # Yukinord Cyan (Sky)
    teal = "#8fbcbb"; # Yukinord Teal
    border = "#3b4252"; # Surface0 (Borders)
    selection = "#5e81ac"; # Sapphire (Selection)
    statusbar = "#2B3442"; # Thanh trạng thái Yukinord
    alpha = "0.8"; # Độ trong suốt cho ST
  };

  # --- CẤU HÌNH FONT ĐÃ PHÂN TÁCH ---
  # Font giao diện (Trình duyệt, Apps)
  fontInter = {
    name = "Inter";
    size = multiply 11;
  };

  # Font cho Terminal & Launcher
  fontJetBrains = {
    name = "JetBrainsMono Nerd Font";
    size = multiply 14;
  };

  # Font cho DWM Bar
  fontBlex = {
    name = "BlexMono Nerd Font";
    size = multiply 12;
  };

  cursorConfig = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = multiply 24;
  };

in
{
  # ========================================================================
  # 2. XRESOURCES (PHÂN TÁCH FONT CHO TỪNG APP & ĐỒNG BỘ MÀU)
  # ========================================================================
  xresources.properties = {
    # --- Màu sắc hệ thống (Mocha-Yukinord) ---
    "*.background" = palette.bg;
    "*.foreground" = palette.fg;
    "*.alpha" = palette.alpha;
    "st.alpha" = palette.alpha;

    # Normal Colors
    "*.color0" = palette.bg;
    "*.color1" = palette.red;
    "*.color2" = palette.green;
    "*.color3" = palette.yellow;
    "*.color4" = palette.blue;
    "*.color5" = palette.purple;
    "*.color6" = palette.cyan;
    "*.color7" = palette.fg;

    # Bright Colors
    "*.color8" = palette.comment;
    "*.color9" = palette.red;
    "*.color10" = palette.green;
    "*.color11" = palette.yellow;
    "*.color12" = palette.selection;
    "*.color13" = palette.purple;
    "*.color14" = palette.teal;
    "*.color15" = palette.fg;

    # --- DWM (Dùng BlexMono) ---
    "dwm.normbgcolor" = palette.bg;
    "dwm.normfgcolor" = palette.subtext;
    "dwm.normbordercolor" = palette.border;
    "dwm.selbgcolor" = palette.statusbar;
    "dwm.selfgcolor" = palette.fg;
    "dwm.selbordercolor" = palette.red;
    "dwm.font" = "${fontBlex.name}:pixelsize=${toString fontBlex.size}:style=semibold";

    # --- ST (Dùng JetBrainsMono) ---
    "st.font" =
      "${fontJetBrains.name}:pixelsize=${toString fontJetBrains.size}:antialias=true:autohint=true";

    # --- DMENU (Dùng JetBrainsMono - đồng bộ với terminal) ---
    "dmenu.font" = "${fontJetBrains.name}:size=${toString (multiply 13)}";
    "dmenu.background" = palette.bg;
    "dmenu.foreground" = palette.fg;
    "dmenu.selbackground" = palette.red;
    "dmenu.selforeground" = palette.fg;

    # --- Cursor ---
    "Xcursor.size" = cursorConfig.size;
    "Xcursor.theme" = cursorConfig.name;
  };

  # ========================================================================
  # 3. GIAO DIỆN GTK & QT (DÙNG INTER)
  # ========================================================================
  gtk = {
    enable = true;
    font = {
      name = fontInter.name;
      size = fontInter.size;
      package = pkgs.inter;
    };
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };

  # ========================================================================
  # 4. CON TRỎ CHUỘT
  # ========================================================================
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = cursorConfig.name;
    package = cursorConfig.package;
    size = cursorConfig.size;
  };

  home.sessionVariables = {
    GTK_THEME = "Nordic";
    XCURSOR_SIZE = "${toString cursorConfig.size}";
    XCURSOR_THEME = "${cursorConfig.name}";
  };
}
