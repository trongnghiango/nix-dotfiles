# Combined Files Documentation

**Generated on:** 2026-01-30 19:06:49
**Source directory:** `/home/ka/.dotfiles/nixos`
**Output file:** `/home/ka/.dotfiles/output.md`

## Summary
This document contains combined contents of text/source files from the specified directory.

---

## File: `flake.nix`
```text
{
  description = "NixOS Pro Configuration - Multi-host System";

  inputs = {
    # NixOS 25.11 (Bản mới nhất tại thời điểm hiện tại)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    # Home Manager đồng bộ version 25.11
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # --- Suckless Sources (Git Prod) ---
    dwm-src = {
      url = "github:trongnghiango/nix-suckless?dir=dwm";
      flake = false;
    };
    st-src = {
      url = "github:trongnghiango/nix-suckless?dir=st";
      flake = false;
    };
    dmenu-src = {
      url = "github:trongnghiango/nix-suckless?dir=dmenu";
      flake = false;
    };
    dwmblocks-src = {
      url = "github:trongnghiango/nix-suckless?dir=dwmblocks";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      # 1. BIẾN TOÀN CỤC (Để đổi 1 nơi là cả hệ thống đổi theo)
      user = "ka";
      dotfilesPath = "/home/${user}/.dotfiles";

      # 2. HÀM TẠO HOST (HÀM THẦN THÁNH ĐỂ TÁCH BIỆT PHẦN CỨNG)
      # Giúp tạo máy mới chỉ trong 1 dòng code
      mkSystem =
        {
          hostName,
          deviceType,
          bootMode,
          uiScale,
          gpuType,
          display,
        }:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          # Truyền biến vào các file modules/*.nix (NixOS level)
          specialArgs = {
            inherit
              inputs
              hostName
              user
              gpuType
              display
              ;
            isLaptop = (deviceType == "laptop");
            isEfi = (bootMode == "efi");
            scale = uiScale;
          };

          modules = [
            # Nạp cấu hình riêng của từng Host (Ví dụ: hosts/thinkbox/default.nix)
            ./hosts/${hostName}/default.nix

            # Cấu hình Home Manager
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                users.${user} = import ./home/home.nix;

                # Truyền biến vào các file home/*.nix (Home Manager level)
                # Giúp theme.nix tự động co giãn font/cursor theo máy
                extraSpecialArgs = {
                  inherit
                    inputs
                    user
                    gpuType
                    display
                    ;
                  dotfiles = dotfilesPath;
                  isLaptop = (deviceType == "laptop");
                  scale = uiScale;
                };
              };
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        # =============================================================
        # 3. DANH SÁCH CÁC MÁY (HOSTS)
        # Cú pháp: mkSystem { hostName, deviceType, bootMode, uiScale }
        # =============================================================

        # ThinkPad X230: Laptop, Boot EFI, Màn hình nhỏ (Scale 1.0)
        thinkbox = mkSystem {
          hostName = "thinkbox";
          deviceType = "laptop";
          bootMode = "efi";
          uiScale = 1.0;
          gpuType = "intel-legacy";
          display = {
            width = 1360;
            height = 768;
            rate = 60;
            barHeight = 24;
            gap = 8;
          };
        };

        # Máy ảo Z600 hoặc PC cũ: Desktop, Boot BIOS, Màn hình nhỏ (Scale 1.0)
        # Chú ý: Cần chỉnh optimize-hw.nix để cài Grub vào đúng ổ đĩa.
        vm-z600 = mkSystem {
          hostName = "vm-z600";
          deviceType = "desktop";
          bootMode = "bios";
          uiScale = 1.0;
          gpuType = "virtio"; # <-- Đánh dấu cho Máy ảo
          display = {
            width = 1920;
            height = 1080;
            rate = 60;
            barHeight = 32;
            gap = 8;
          };
        };

        # Host mới cho máy ảo
        vm-x230 = mkSystem {
          hostName = "vm-x230";
          deviceType = "desktop"; # Chọn desktop để tắt TLP pin
          bootMode = "efi"; # Thường máy ảo hiện đại chọn EFI (OVMF)
          uiScale = 1.0; # Máy ảo cửa sổ nhỏ nên để scale 1.0
          gpuType = "virtio"; # <-- Đánh dấu cho Máy ảo
          display = {
            width = 1360;
            height = 768;
            rate = 60;
            barHeight = 30;
            gap = 8;
          };
        };

        # Demo máy 4K trong tương lai (Ví dụ Workstation)
        # workstation = mkSystem {
        #   hostName = "workstation";
        #   deviceType = "desktop";
        #   bootMode = "efi";
        #   uiScale = 1.5; # Chữ tự động to ra 1.5 lần
        # };
      };
    };
}

```

## File: `home/theme_2.nix`
```text
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

```

## File: `home/theme.nix`
```text
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

```

## File: `home/home.nix`
```text
# ---
# User (home.nix): Chứa toàn bộ ứng dụng người dùng, giao diện, dev tools.
# ---

{
  config,
  pkgs,
  dotfiles,
  user,
  ...
}:

let
  # =====================================================================
  # 1. USER APPLICATIONS (End-user Software)
  # Nhóm này chứa các ứng dụng chính bạn tương tác trực tiếp
  # =====================================================================
  userApps = with pkgs; [
    # --- Web Browser ---
    # librewolf # (Đã có script wrapper riêng, có thể uncomment nếu muốn cài native)
    # brave     # (Cài qua module programs.brave bên dưới sẽ tốt hơn)

    # --- Database Management ---
    dbeaver-bin

    # --- Media ---
    nsxiv # Xem ảnh (Suckless style)
    zathura # Đọc PDF (Vim keybindings)
    mpv # Xem Video (Nhẹ, scriptable)
    yt-dlp # ho tro xem yt cho trinh duyet qute
    calcurse # Lịch (TUI)
    pavucontrol # Chỉnh âm thanh (GUI cho Pipewire)
  ];

  # =====================================================================
  # 2. DESKTOP UTILITIES (The "Glue" of DWM)
  # Nhóm này chứa các công cụ hỗ trợ giao diện, chạy nền, script backend
  # =====================================================================
  desktopUtilities = with pkgs; [
    # --- Core UI ---
    #picom # Compositor
    xcompmgr # Bộ trộn cửa sổ (giúp ST trong suốt)
    dunst # Trình thông báo
    unclutter # Tự ẩn chuột khi không dùng
    rofi # App Launcher & Menu
    trayer # System Tray (cho các app như nm-applet)
    xwallpaper # Wallpaper setter (nhẹ hơn feh)
    arandr # GUI chỉnh màn hình (tạo script xrandr)
    networkmanagerapplet # Icon Wifi trên tray

    # --- Scripting & Backend UI ---
    yad # Tạo hộp thoại GUI cho script (quan trọng)
    libnotify # Lệnh notify-send

    # --- Clipboard Manager ---
    clipmenu # Quản lý lịch sử copy (dùng dmenu/rofi)
    xclip # Backend copy/paste cho X11

    # --- Screenshot & Automation ---
    maim # Chụp ảnh màn hình (tốt hơn scrot)
    slop # Chọn vùng màn hình (dùng với maim)
    xdotool # Giả lập phím/chuột (cho script)
    brightnessctl # Chỉnh độ sáng màn hình

    # --- System Monitoring ---
    pkgs.libva-utils # Kiểm tra driver đồ họa (vainfo)

  ];

  # =====================================================================
  # 3. SYSTEM TOOLS (CLI / TUI)
  # Nhóm công cụ dòng lệnh, quản lý hệ thống, xử lý file
  # =====================================================================
  cliTools = with pkgs; [
    # --- Core System ---
    neofetch
    htop
    btop
    trash-cli

    # --- File Manager & Archives ---
    lf # File manager (Ranger like)
    ueberzugpp # Preview ảnh cho LF
    atool # Quản lý nén file đa năng
    unzip
    unrar

    # --- Media Processing ---
    ffmpeg
    ffmpegthumbnailer
    imagemagick
    poppler-utils # pdftoppm (preview pdf)
    mediainfo
    ghostscript

    # --- Network & Text Processing ---
    newsboat # RSS Reader
    neomutt # Email Client
    jq # Xử lý JSON
    socat # Socket cat
    bc # Máy tính
    file
    rsync

    # --- Utilities ---
    util-linux # setsid, v.v.
    sqlite
    tectonic # LaTeX engine hiện đại
  ];

  # =====================================================================
  # 4. AUDIO TOOLS (CLI)
  # =====================================================================
  audioTools = with pkgs; [
    pulsemixer # TUI Mixer (nhẹ)
    pamixer # CLI Volume control
    wireplumber # Quản lý session Pipewire
    mpc # Điều khiển MPD
    ncmpcpp # Giao diện nghe nhạc MPD
  ];

  # =====================================================================
  # 5. DEVELOPMENT RUNTIMES
  # Môi trường chạy ngôn ngữ lập trình
  # =====================================================================
  devRuntimes = with pkgs; [
    nodejs_22
    python3
    go
    zig
    gcc # Cần cho Treesitter / CGO
    gnumake
  ];

  # =====================================================================
  # 6. NEOVIM & LSP (Thay thế Mason)
  # Cài đặt LSP qua Nix để ổn định trên NixOS
  # =====================================================================
  lspServers = with pkgs; [
    lua-language-server
    gopls
    zls
    nodePackages.typescript-language-server
    rust-analyzer
    pyright
    vscode-langservers-extracted # HTML/CSS/JSON
    bash-language-server
    nil # Nix LSP
  ];

  # =====================================================================
  # 7. FORMATTERS & LINTERS
  # =====================================================================
  formattersAndLinters = with pkgs; [
    stylua
    gotools # goimports
    nodePackages.prettier
    nodePackages.eslint_d
    shellcheck
    shfmt
    ruff # Python linter (nhanh)
    nixfmt-rfc-style
  ];

  # =====================================================================
  # 8. NEOVIM ESSENTIALS
  # Các công cụ bổ trợ cho Neovim (Telescope, Treesitter cần mấy cái này)
  # =====================================================================
  neovimEssentials = with pkgs; [
    neovim
    lazygit
    ripgrep
    fd
    eza
    bat
    fzf
    tree-sitter # CLI
  ];

in
{
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";

  # =====================================================================
  # IMPORT MODULES
  # Tách biệt cấu hình giao diện ra file riêng cho gọn
  # =====================================================================
  imports = [
    ./theme.nix # <-- File cấu hình GTK/Cursor/Font bạn vừa tạo
    ./programs/brave.nix
    ./programs/appimages.nix
    ./programs/min-browser.nix
    ./programs/qutebrowser.nix
  ];

  # =====================================================================
  # CÀI ĐẶT PACKAGES
  # Kết hợp các nhóm đã định nghĩa ở trên
  # =====================================================================
  home.packages =
    userApps
    ++ desktopUtilities
    ++ cliTools
    ++ audioTools
    ++ devRuntimes
    ++ lspServers
    ++ formattersAndLinters
    ++ pkgs.lib.optionals true neovimEssentials;

  # =====================================================================
  # 2. INPUT METHOD (BỘ GÕ TIẾNG VIỆT) - CLEAN WAY
  # =====================================================================
  i18n.inputMethod = {
    enable = true; # Thay cho enabled = "fcitx5"
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-bamboo
      qt6Packages.fcitx5-unikey
      fcitx5-gtk
    ];
  };

  # =====================================================================
  # SYMLINK CONFIGURATION (Clean Home Strategy)
  # Liên kết trực tiếp từ Dotfiles Git Repo -> Home
  # =====================================================================
  home.file = {
    # Pointer cho Zsh (Giữ Home sạch sẽ)
    ".zshenv".text = ''
      export ZDOTDIR="$HOME/.config/zsh"
      export XDG_CONFIG_HOME="$HOME/.config"

      # Load Profile từ Dotfiles (Nơi chứa mọi logic: env, alias, startx)
      if [[ -f "$XDG_CONFIG_HOME/shell/profile" ]]; then
        source "$XDG_CONFIG_HOME/shell/profile"
      fi
    '';

    # -- Shell & Core --
    ".config/zsh".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/zsh/.config/zsh";
    ".config/shell".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/shell/.config/shell";

    # -- Applications --
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/nvim/.config/nvim";
    ".config/lf".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/lf/.config/lf";
    ".config/rofi".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/rofi/.config/rofi";
    ".config/dunst".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/dunst/.config/dunst";
    ".config/librewolf".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/librewolf/.config/librewolf";
    ".config/tmux".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/tmux/.config/tmux";

    # -- Media --
    ".config/mpd".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/media/.config/mpd";
    ".config/ncmpcpp".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/media/.config/ncmpcpp";
    ".config/mpv".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/media/.config/mpv";
    ".config/nsxiv".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/nsxiv/.config/nsxiv";
    ".config/newsboat".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/bin/.local/share/newsboat";

    # -- X11 & Scripts --
    ".xinitrc".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/x11/.config/x11/xinitrc";
    ".xprofile".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/x11/.config/x11/xprofile";
    ".config/x11".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/x11/.config/x11";

    # -- Custom Scripts (Tách biệt) --
    ".local/bin".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/scripts/.local/bin";
  };

  # =====================================================================
  # ENVIRONMENT VARIABLES & PATH
  # =====================================================================
  home.sessionPath = [
    #"$HOME/.local/bin" # DWM, ST (Compiled)
    "$HOME/go/bin" # Go Tools
    "$HOME/.cargo/bin" # Rust Tools
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "st";
    BROWSER = "brave";
    # Fix Java apps (IntelliJ, Minecraft...) bị lỗi hiển thị trong DWM
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  # (Đã xóa phần gtk = { ... } vì đã chuyển sang theme.nix)

  xdg.desktopEntries = {
    # Định nghĩa entry cho LF File Manager (sử dụng lfub)
    "lf" = {
      name = "LF File Manager";
      genericName = "File Manager";
      comment = "Terminal file manager with image previews";

      # Quan trọng: Chạy lfub bên trong terminal st
      exec = "st -e lfub %u";

      icon = "system-file-manager";
      terminal = false; # Để false vì ta đã gọi 'st -e' rồi
      categories = [
        "System"
        "FileTools"
        "FileManager"
      ];
      mimeType = [ "inode/directory" ];
    };

    # Bạn có thể thêm các app khác tại đây nếu muốn
    # "my-script" = { ... };
  };

  home.stateVersion = "25.11";
}

```

## File: `home/programs/min-browser.nix`
```text
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

```

## File: `home/programs/qutebrowser.nix`
```text
{
  pkgs,
  gpuType,
  scale,
  ...
}:

let
  # Nhân tỉ lệ cho font giống như đã làm ở theme.nix
  multiply = size: builtins.floor (size * scale);

  # --- DANH SÁCH BỘ LỌC UBLOCK ORIGIN "THẦN THÁNH" ---
  adblockLists = [
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt"
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt"
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt"
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt"
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt"
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt"
    "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
  ];

  # Palette màu Yukinord của mày
  palette = {
    bg = "#1B212B";
    fg = "#eceff4";
    red = "#bf616a";
    orange = "#d08770";
    yellow = "#ebcb8b";
    green = "#a3be8c";
    blue = "#81a1c1";
    purple = "#b48ead";
    cyan = "#88c0d0";
    statusbar = "#2B3442";
    selection = "#5e81ac";
  };
in
{
  programs.qutebrowser = {
    enable = true;

    # CHIÊU THỨC "BƠM THUỐC": Ép qutebrowser phải nhận thư viện adblock và tldextract
    package = pkgs.qutebrowser.override {
      python3 = pkgs.python3.withPackages (
        ps: with ps; [
          adblock
          tldextract
          pyyaml
          jinja2
          pygments
        ]
      );
    };

    # --- TỐI ƯU CHO PHẦN CỨNG X230 / MÁY ẢO ---
    extraConfig = ''
      # Tăng tốc phần cứng dựa trên gpuType
      config.set('qt.args', [
        ${
          if gpuType == "intel-legacy" then
            "'--ignore-gpu-blocklist', '--enable-gpu-rasterization', '--enable-zero-copy'"
          else
            "'--disable-gpu'"
        }
      ])
    '';

    settings = {
      # Chặn quảng cáo (Vũ khí tối thượng cho máy yếu)
      content.blocking.method = "both"; # Dùng cả Brave-style và Host-style

      # ĐƯA DANH SÁCH VÀO ĐÂY (Nix sẽ tự chuyển thành mảng trong config.py)
      "content.blocking.adblock.lists" = adblockLists;

      # Tự động nạp danh sách các trang web chặn quảng cáo
      "content.blocking.hosts.lists" = [
        "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
        "https://adaway.org/hosts.txt"
      ];

      # Chặn các script theo dõi làm nặng máy
      content.canvas_reading = false; # Chống fingerprinting
      content.webgl = true; # Giữ cái này để xem video mượt

      # --- GIAO DIỆN & FONT ---
      fonts.default_family = "JetBrainsMono Nerd Font";
      fonts.default_size = "${toString (multiply 11)}pt";

      zoom.default = multiply 100; # Tự động zoom nếu là màn 4K

      # Tắt thanh Tab nếu chỉ mở 1 tab cho sạch (Suckless style)
      tabs.show = "multiple";
      tabs.position = "top";

      # --- BẢNG MÀU YUKINORD ---
      colors = {
        # Background của trang web khi chưa load xong
        webpage.bg = palette.bg;

        # Thanh trạng thái (Statusbar)
        statusbar.normal.bg = palette.statusbar;
        statusbar.normal.fg = palette.fg;
        statusbar.insert.bg = palette.green;
        statusbar.insert.fg = palette.bg;
        statusbar.command.bg = palette.bg;
        statusbar.command.fg = palette.fg;

        # Tab Bar
        tabs.bar.bg = palette.bg;
        tabs.even.bg = palette.bg;
        tabs.even.fg = palette.fg;
        tabs.odd.bg = palette.bg;
        tabs.odd.fg = palette.fg;
        tabs.selected.even.bg = palette.selection;
        tabs.selected.even.fg = palette.fg;
        tabs.selected.odd.bg = palette.selection;
        tabs.selected.odd.fg = palette.fg;

        # Hints (Cái chữ hiện lên để nhấn phím nhảy link)
        # Ép dùng màu Đỏ Yukinord để nổi bật
        hints.bg = palette.red;
        hints.fg = palette.bg;
        hints.match.fg = palette.yellow;

        # Completion menu (Lúc gõ lệnh)
        completion.category.bg = palette.statusbar;
        completion.category.fg = palette.cyan;
        completion.item.selected.bg = palette.selection;
        completion.item.selected.fg = palette.fg;
        completion.match.fg = palette.orange;
      };
    };

    # --- PHÍM TẮT ---
    keyBindings = {
      normal = {
        "M" = "spawn mpv {url}"; # Nhấn Shift + M là mở MPV xem luôn
        "J" = "tab-prev";
        "K" = "tab-next";
        "x" = "tab-close";
        "t" = "set-cmd-text -s :open -t";
      };
    };
  };
}

```

## File: `home/programs/brave.nix`
```text
{ pkgs, gpuType, ... }:

let
  # --- LOGIC TỐI ƯU THEO PHẦN CỨNG ---
  braveArgs =
    let
      base = [
        "--password-store=basic"
        "--process-per-site"
        "--incognito" # Ví dụ: Luôn mở ẩn danh cho máu
      ];

      intelLegacy = [
        "--ignore-gpu-blocklist"
        "--enable-gpu-rasterization"
        "--enable-zero-copy"
        "--use-gl=egl"
      ];

      virtio = [
        "--disable-gpu"
      ];
    in
    base
    ++ (
      if gpuType == "intel-legacy" then
        intelLegacy
      else if gpuType == "virtio" then
        virtio
      else
        [ ]
    );
in
{
  programs.brave = {
    enable = true;
    commandLineArgs = braveArgs;

    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
      { id = "omkfmpieigblcllmkgbflkikinpkodjg"; } # enhanced-h264ify
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # Vimium
    ];
  };
}

# commandLineArgs = [
#   "--enable-features=VaapiVideoDecodeLinuxGL" # VA-API Video Decode
#   "--use-gl=egl"
#   "--ignore-gpu-blocklist" # Ép chạy GPU cũ
#   "--enable-gpu-rasterization"
#   "--enable-zero-copy"
#   "--process-per-site" # Tiết kiệm RAM
# ];

```

## File: `home/programs/appimages.nix`
```text
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

```

## File: `hosts/vm-x230/optimize-hw.nix`
```text
{ config, pkgs, isEfi, ... }:

{
  # --- 1. BOOTLOADER (Dựa trên thông số từ Flake) ---
  boot.loader = if isEfi then {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    systemd-boot.configurationLimit = 3; # Máy ảo nên để ít generation cho nhẹ ổ đĩa
  } else {
    grub = {
      enable = true;
      # Trong máy ảo QEMU thường là /dev/vda, VirtualBox là /dev/sda
      device = "/dev/vda"; 
    };
  };

  # --- 2. ĐỒ HỌA MÁY ẢO (Dùng Virtio thay vì i965) ---
  # Virtio là driver chuẩn giúp máy ảo có hiệu suất đồ họa tốt nhất
  services.xserver.videoDrivers = [ "virtio" ];

  # --- 3. DỊCH VỤ HỖ TRỢ MÁY ẢO (GUEST AGENTS) ---
  services.qemuGuest.enable = true;      # Hỗ trợ tắt máy/nút bấm từ host
  services.spice-vdagentd.enable = true; # Quan trọng: Giúp Copy/Paste giữa máy thật và máy ảo
  
  # --- 4. TỐI ƯU HÓA (XÓA BỎ CÁC THỨ KHÔNG CẦN THIẾT) ---
  # Máy ảo không có Pin thật nên tắt hoàn toàn TLP
  services.tlp.enable = false;
  powerManagement.cpuFreqGovernor = "performance";

  # Mount folder chia sẻ từ Host (nếu cần)
  # fileSystems."/mnt/shared" = {
  #   device = "shared_folder_name";
  #   fsType = "9p";
  #   options = [ "trans=virtio" "version=9p2000.L" ];
  # };
}

```

## File: `hosts/vm-x230/hardware-configuration.nix`
```text
# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/profiles/qemu-guest.nix")
    ];

  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/7cdd86e3-4b04-4a3c-849a-ab0ffdf3be05";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/B0AE-0A00";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}

```

## File: `hosts/vm-x230/default.nix`
```text
{ config, pkgs, hostName, ... }:

{
  imports = [
    ./hardware-configuration.nix # File này sẽ được gen khi bạn cài máy ảo
    ./optimize-hw.nix            # Tối ưu dành riêng cho môi trường ảo hóa
    ../../modules/core.nix
    ../../modules/shell.nix
    ../../modules/user.nix
    ../../modules/desktop.nix
    ../../modules/audio.nix
  ];

  networking.hostName = hostName;

  # State version theo đúng bản flake
  system.stateVersion = "25.11";
}


```

## File: `hosts/vm-z600/default.nix`
```text
{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core.nix
    ../../modules/shell.nix
    ../../modules/user.nix
    ../../modules/desktop.nix
    ../../modules/audio.nix
  ];

  networking.hostName = "vm-z600";

  # ============================
  # NETWORK (VM)
  # ============================
  networking.networkmanager.enable = true;

  # ============================
  # BOOTLOADER (LEGACY BIOS)
  # ============================
  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";   # đĩa virtio của VM
    useOSProber = false;
  };

  # ❌ TẮT HOÀN TOÀN EFI CHO VM
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = false;

  # ============================
  # VM OPTIMIZATION
  # ============================

  # Guest tools cho libvirt / virt-manager
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  # VirtIO + OpenGL (cho desktop.nix dùng)
  services.xserver.videoDrivers = [ "virtio" ];
  hardware.opengl.enable = true;

  # CPU/RAM tuning nhẹ cho VM
  nix.settings = {
    max-jobs = lib.mkDefault 4;
    cores = lib.mkDefault 4;
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
    "vm.vfs_cache_pressure" = 50;
  };

  # Log gọn cho VM
  services.journald.extraConfig = ''
    SystemMaxUse=200M
    RuntimeMaxUse=100M
  '';

  system.stateVersion = "25.11";
}

```

## File: `hosts/thinkbox/optimize-hw.nix`
```text
{ config, pkgs, ... }:

{
  # --- 1. Drivers Đồ họa (Đặc thù cho Intel HD 4000) ---
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-vaapi-driver # i965 chuẩn cho Ivy Bridge
      libvdpau-va-gl
      vaapiIntel
    ];
  };

  # --- 2. Biến môi trường đồ họa ---
  environment.sessionVariables = { 
    LIBVA_DRIVER_NAME = "i965"; 
  };

  # --- 3. Cấu hình Xserver cho chip cũ ---
  services.xserver.videoDrivers = [ "modesetting" ];
  # services.xserver.videoDrivers = [ "virtio" ]; # virt-machine

  # --- 4. Tối ưu Kernel cho phần cứng ThinkPad X230 ---
  boot.initrd.kernelModules = [ "i915" ];
  boot.kernelParams = [ 
    "i915.enable_fbc=1" 
    "i915.enable_psr=0" # Fix nháy màn hình X230
    "intel_iommu=on"
  ];

  # --- 5. Hỗ trợ CPU Intel ---
  hardware.cpu.intel.updateMicrocode = true;
  
  # Quản lý điện năng cho Laptop cũ
  services.tlp.enable = true; 
}

```

## File: `hosts/thinkbox/hardware-configuration.nix`
```text
# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/profiles/qemu-guest.nix")
    ];

  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/c3cc0718-71d9-43f2-bc2e-493f6685eb36";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/D237-82C5";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/3c7aaf53-a31c-45ab-aaa0-798c0ff7eaca"; }
    ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}

```

## File: `hosts/thinkbox/default.nix`
```text
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix # Nhớ copy file này từ /etc/nixos/ vào
    ../../modules/core.nix
    ../../modules/shell.nix
    ../../modules/user.nix
    ../../modules/desktop.nix
    ../../modules/audio.nix
  ];

  # Bootloader: Systemd-boot (UEFI). Nếu máy cũ dùng BIOS Legacy, hãy đổi sang Grub.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "thinkbox";
  networking.networkmanager.enable = true;

  system.stateVersion = "25.11"; 
  # Force rebuild hash ccc ccc
}

```

## File: `modules/audio.nix`
```text
{ config, pkgs, ... }:

{
  # Tắt PulseAudio cũ để tránh conflict
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true; # Layer tương thích PulseAudio
    wireplumber.enable = true;
  };
}


```

## File: `modules/core.nix`
```text
# ------
# System (core.nix): Chỉ chứa driver, kernel, công cụ cứu hộ (vim, git) và những thứ cần quyền root.
# ------
{ config, pkgs, ... }:

{
  # 1. Thời gian & Ngôn ngữ
  time.timeZone = "Asia/Ho_Chi_Minh";
  i18n.defaultLocale = "en_US.UTF-8";

  # 2. Cấu hình Nix (Dọn rác & Tối ưu)
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # 3. Hỗ trợ chạy Binary tải ngoài
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    openssl
    curl
    glib
  ];

  # 4. Cấu hình Console TTY
  console = {
    enable = true;
    font = "ter-v24b";
    packages = with pkgs; [ terminus_font ];
    keyMap = "us";
  };

  # 5. Cấu hình Fonts Hệ thống
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.blex-mono
    nerd-fonts.iosevka
    inter
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [
        "JetBrainsMono Nerd Font"
        "Noto Color Emoji"
      ];
      serif = [
        "Noto Serif"
        "Noto Color Emoji"
      ];
      sansSerif = [
        "Inter"
        "Noto Color Emoji"
      ];
    };
  };

  # 6. SSH
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
  };
  networking.firewall.allowedTCPPorts = [ 22 ];

  # 7. Gói hệ thống cốt lõi
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    htop
  ];

}

```

## File: `modules/shell.nix`
```text
{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  # Chỉ cần trỏ đúng 1 file profile là xong!
  # environment.etc."zshenv".text = ''
  #   # Thiết lập biến môi trường cơ bản để tìm được file config
  #   export XDG_CONFIG_HOME="$HOME/.config"
  #
  #   #
  #   #export PATH="$HOME/.dotfiles/bin/.local/bin:$HOME/.dotfiles/user-bin/.local/bin:$HOME/.local/bin:$PATH"
  #
  #   # Load Profile từ Dotfiles (Nơi chứa mọi logic: env, alias, startx)
  #   if [[ -f "$XDG_CONFIG_HOME/shell/profile" ]]; then
  #     source "$XDG_CONFIG_HOME/shell/profile"
  #   fi
  #
  #   # Zsh Config location
  #   if [[ -d "$XDG_CONFIG_HOME/zsh" ]]; then
  #     export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
  #   fi
  # '';

  environment.systemPackages = with pkgs; [
    fzf
    eza
    bat
    zoxide
    fnm
  ];

  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
}

```

## File: `modules/desktop.nix`
```text
{
  config,
  pkgs,
  inputs,
  hostName,
  display,
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

        # =============================================================
        # TỐI ƯU HÓA PRE-BUILD: TIÊM THÔNG SỐ MÀN HÌNH
        # =============================================================
        preBuild = ''
          # 1. Kiểm tra và chuẩn bị file config.h
          if [ ! -f config.h ]; then
            cp config.def.h config.h
          fi

          # 2. Sử dụng Regex (sed) để sửa giá trị trong code C dựa trên thông số từ Flake
          # Cách này "bất tử" vì nó tìm theo tên biến, không quan tâm giá trị cũ là bao nhiêu.

          # Sửa chiều cao thanh Bar
          sed -i 's/static const int bar_height[[:space:]]*=[[:space:]]*[0-9]\+;/static const int bar_height = ${toString display.barHeight};/' config.h

          # Sửa khoảng cách Gaps (inner gaps ngang và dọc)
          sed -i 's/static const unsigned int gappih[[:space:]]*=[[:space:]]*[0-9]\+;/static const unsigned int gappih = ${toString display.gap};/' config.h
          sed -i 's/static const unsigned int gappiv[[:space:]]*=[[:space:]]*[0-9]\+;/static const unsigned int gappiv = ${toString display.gap};/' config.h

          echo "=> [Nix Build] DWM optimized for ${hostName}: Bar=${toString display.barHeight}px, Gaps=${toString display.gap}px"
        '';

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

  # --- System Services ---
  services.gvfs.enable = true; # Mount ổ đĩa, USB
  services.udisks2.enable = true; # Quản lý ổ đĩa
  services.libinput.enable = true; # Touchpad
  programs.dconf.enable = true; # Cần cho GTK apps
}

```

## File: `modules/user.nix`
```text
{ config, pkgs, ... }:

{
  users.users.ka = {
    isNormalUser = true;
    description = "Ka";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "storage" ];
    shell = pkgs.zsh;
  };
}


```


---

## Statistics
- **Total files found:** 0
- **Files processed:** 0
- **Files ignored:** 0

**Generation completed:** 2026-01-30 19:06:50
