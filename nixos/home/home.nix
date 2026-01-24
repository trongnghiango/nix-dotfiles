{ config, pkgs, dotfiles, ... }:

let
  # --- 1. CORE PACKAGES ---
  # Các công cụ hệ thống và tiện ích dòng lệnh thiết yếu
  coreUtils = with pkgs; [
    # System
    busybox
    htop
    btop
    libnotify       # notify-send
    inotify-tools   # Theo dõi file thay đổi
    jq              # Xử lý JSON (cho script weather/network)
    bc              # Máy tính dòng lệnh
    killall
    procps          # pgrep, pkill
    
    # Archives & Files
    atool unzip unrar p7zip
    trash-cli
    fzf             # Tìm kiếm mờ
    ripgrep         # Grep siêu tốc
    fd              # Find siêu tốc
    eza             # ls thay thế
    bat             # cat thay thế
    zoxide          # cd thay thế
    
    # File Manager
    lf
    ueberzugpp      # Preview ảnh cho LF
  ];

  # --- 2. DESKTOP ENVIRONMENT (DWM Support) ---
  # Các gói hỗ trợ giao diện đồ họa X11
  desktopUtils = with pkgs; [
    # Window Manager Tools
    xdotool         # Giả lập phím/chuột
    xorg.xprop      # Thông tin cửa sổ
    xorg.xset       # Quản lý màn hình/phím
    xorg.xrandr     # Chỉnh độ phân giải
    arandr          # GUI cho xrandr
    xwallpaper      # Set hình nền
    picom           # Compositor (trong suốt/bóng)
    dunst           # Thông báo
    rofi            # Menu/Launcher
    
    # Status Bar & Tray
    # dwmblocks (Đã cài ở system level hoặc compile tay)
    trayer-srg      # System tray (Bản fork tốt hơn trayer gốc)
    networkmanagerapplet
    
    # Screenshot & Clipboard
    maim            # Chụp ảnh
    slop            # Chọn vùng
    xclip           # Clipboard backend
    clipmenu        # Clipboard manager
    
    # Hardware Controls
    brightnessctl   # Độ sáng
    pamixer         # Âm thanh CLI
    pavucontrol     # Âm thanh GUI
    playerctl       # Media keys (Play/Pause)
  ];

  # --- 3. USER APPLICATIONS ---
  userApps = with pkgs; [
    # Web & Chat
    # brave (Cấu hình qua module riêng bên dưới)
    
    # Media
    mpv             # Video player
    nsxiv           # Image viewer
    zathura         # PDF Reader
    newsboat        # RSS TUI
    calcurse        # Calendar TUI
    
    # Dev & Database
    dbeaver-bin     # DB Manager
    lazygit         # Git TUI
    gnumake
    gcc
  ];

  # --- 4. DEV RUNTIMES & LSP ---
  # Tách biệt Dev tools để dễ quản lý
  devTools = with pkgs; [
    # Languages
    nodejs_22
    python3
    go
    zig
    
    # LSPs (Hỗ trợ Neovim Mason/Native)
    lua-language-server
    gopls
    zls
    nodePackages.typescript-language-server
    bash-language-server
    nil             # Nix LSP
    
    # Formatters
    stylua
    shfmt
    nixfmt-rfc-style
    nodePackages.prettier
  ];

in
{
  home.username = "ka";
  home.homeDirectory = "/home/ka";
  home.stateVersion = "25.11";

  # Import giao diện (GTK/Cursor)
  imports = [ ./theme.nix ];

  # =====================================================================
  # 1. PACKAGE INSTALLATION
  # =====================================================================
  home.packages = coreUtils ++ desktopUtils ++ userApps ++ devTools ++ [
    pkgs.fcitx5-configtool
  ];

  # =====================================================================
  # 2. INPUT METHOD (BỘ GÕ TIẾNG VIỆT) - CLEAN WAY
  # =====================================================================
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk        # Hỗ trợ app GTK
      fcitx5-unikey     # Engine Unikey cũ
      fcitx5-bamboo     # Engine Bamboo mới (Khuyên dùng)
    ];
  };
  # Cài thêm tool config (nằm ngoài addons)
  #home.packages = [ pkgs.fcitx5-configtool ];

  # =====================================================================
  # 3. SHELL CONFIGURATION (ZSH - NATIVE MODULE)
  # =====================================================================
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    # Tự động cd bằng zoxide (z <dir>)
    initExtra = ''
      # Load Profile chung (Chứa Alias, Env, Function)
      if [[ -f "$HOME/.config/shell/profile" ]]; then
        source "$HOME/.config/shell/profile"
      fi
      
      # Zoxide hook (NixOS cài zoxide nhưng cần hook này để chạy lệnh z)
      eval "$(zoxide init zsh)"
    '';

    # Biến môi trường hệ thống
    envExtra = ''
      export XDG_CONFIG_HOME="$HOME/.config"
      export PATH="$HOME/.local/bin:$PATH"
    '';
  };

  # Tích hợp sẵn fzf và zoxide qua Home Manager (Pro hơn cài gói lẻ)
  programs.fzf.enable = true;
  programs.zoxide.enable = true;

  # =====================================================================
  # 4. APP CONFIGURATION
  # =====================================================================
  
  # Brave Browser (Tối ưu HD4000)
  programs.brave = {
    enable = true;
    commandLineArgs = [
      "--password-store=basic"                    # Fix lỗi KWallet/Keyring
      "--enable-features=VaapiVideoDecodeLinuxGL" # Hardware Acceleration
      "--use-gl=egl"                              # EGL ổn định hơn GLX cho Intel cũ
      "--ignore-gpu-blocklist"
    ];
  };

  # =====================================================================
  # 5. SYMLINK CONFIGURATION (THE NEW STRUCTURE)
  # =====================================================================
  home.file = {
    # --- 1. CONFIGS (Dùng chung Arch/NixOS) ---
    # Trỏ vào thư mục 'config/' trong dotfiles mới
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/nvim/.config/nvim";
    ".config/zsh".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/zsh/.config/zsh";
    ".config/tmux".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/tmux/.config/tmux";
    ".config/shell".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/shell/.config/shell";
    
    # Các app khác
    ".config/lf".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/lf/.config/lf";
    ".config/rofi".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/rofi/.config/rofi";
    ".config/dunst".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/dunst/.config/dunst";
    ".config/picom".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/picom/.config/picom";

    # --- 2. X11 (Startx & Profile) ---
    ".xinitrc".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/x11/.config/x11/xinitrc";
    ".config/x11".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/x11/.config/x11";

    # --- 3. SCRIPTS (Hợp nhất) ---
    # Chỉ cần một dòng này cho tất cả script trong scripts/.local/bin
    ".local/bin".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/scripts/.local/bin";
  };

  # =====================================================================
  # 6. SESSION VARIABLES
  # =====================================================================
  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "st";
    BROWSER = "brave";
    # Fix Java GUI (IntelliJ, Minecraft...)
    _JAVA_AWT_WM_NONREPARENTING = "1";
    # Fix Brave đòi password khi khởi động
    XDG_CURRENT_DESKTOP = "Undefined";
  };
}
