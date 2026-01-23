{
  config,
  pkgs,
  dotfiles,
  ...
}:

let
  # =====================================================================
  # 1. USER APPLICATIONS (End-user Software)
  # Nhóm này chứa các ứng dụng chính bạn tương tác trực tiếp
  # =====================================================================
  userApps = with pkgs; [
    # Web
    # librewolf # (Đã có script wrapper riêng, có thể uncomment nếu muốn cài native)
    # brave
    # database management
    dbeaver-bin

    # Media
    nsxiv       # Ảnh
    zathura     # PDF
    mpv         # Video
    calcurse    # Lịch
    pavucontrol # Chỉnh âm thanh GUI
  ];

  # =====================================================================
  # 2. DESKTOP UTILITIES (The "Glue" of DWM)
  # Nhóm này chứa các công cụ hỗ trợ giao diện, chạy nền, script backend
  # =====================================================================
  desktopUtilities = with pkgs; [
    # --- Core UI ---
    rofi                    # Launcher
    dunst                   # Notifications
    trayer                  # System Tray
    xwallpaper              # Wallpaper setter
    arandr                  # Screen layout editor
    networkmanagerapplet    # Wifi icon tray

    # --- Scripting & Backend UI (Yad/Zenity...) ---
    yad                     # Tạo GUI dialog cho script (Cần cho clipboard-tray)
    libnotify               # Lệnh notify-send

    # --- Clipboard Manager ---
    clipmenu                # Quản lý lịch sử copy (Gồm clipmenud & clipmenu)
    xclip                   # Backend copy/paste cho X11

    # --- Screenshot & Automation ---
    maim                    # Chụp ảnh màn hình
    slop                    # Chọn vùng màn hình
    xdotool                 # Giả lập thao tác phím/chuột
    brightnessctl           # Chỉnh độ sáng
  ];

  # =====================================================================
  # 3. SYSTEM TOOLS (CLI / TUI)
  # Nhóm công cụ dòng lệnh, quản lý hệ thống, xử lý file
  # =====================================================================
  cliTools = with pkgs; [
    # Core
    neofetch
    htop
    btop
    trash-cli
    
    # File Manager & Archives
    lf
    ueberzugpp
    atool
    unzip
    unrar
    
    # Media processing
    ffmpeg
    ffmpegthumbnailer
    imagemagick
    poppler-utils # pdftoppm
    mediainfo
    ghostscript   # PDF tools

    # Network & Text processing
    newsboat
    neomutt
    jq
    socat
    bc
    file
    rsync
    
    # Utils
    util-linux    # setsid, etc.
    sqlite
    tectonic      # LaTeX
  ];

  # =====================================================================
  # 4. AUDIO TOOLS (CLI)
  # =====================================================================
  audioTools = with pkgs; [
    pulsemixer
    pamixer
    wireplumber
    mpc
    ncmpcpp
  ];

  # 5.
  devRuntimes = with pkgs; [
    nodejs_22
    python3
    go
    zig
    gcc # Cần cho Treesitter / CGO
    gnumake
  ];

  # 6. Neovim & Development Tools (Thay thế Mason)
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

  # 7.
  formattersAndLinters = with pkgs; [
    stylua
    gotools # goimports
    nodePackages.prettier
    nodePackages.eslint_d
    shellcheck
    shfmt
    ruff # Python linter
    nixfmt-rfc-style # Nix formatter
  ];

  # 8. 
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
  home.username = "ka";
  home.homeDirectory = "/home/ka";

  # 2. Cài đặt Packages (Gộp các nhóm đã định nghĩa ở trên)
  # ---------------------------------------------------------------------
  home.packages =
    userApps
    ++ desktopUtilities  # <-- Nhóm mới thêm vào đây
    ++ cliTools
    ++ audioTools
    ++ devRuntimes
    ++ lspServers
    ++ formattersAndLinters
    ++ pkgs.lib.optionals true neovimEssentials; # Ví dụ cách viết pro dùng optionals

  # --- CẤU HÌNH BRAVE TỐI ƯU CHO THINKPAD X230 ---
  programs.brave = {
    enable = true;

    # Các tham số khởi động để ép Brave dùng GPU HD4000 hiệu quả
    commandLineArgs = [
      # Bật giải mã video bằng phần cứng (VA-API)
      "--enable-features=VaapiVideoDecodeLinuxGL"
      "--use-gl=egl"

      # Bỏ qua danh sách đen GPU (vì HD4000 cũ hay bị Google chặn tính năng)
      "--ignore-gpu-blocklist"
      "--enable-gpu-rasterization"
      "--enable-zero-copy"

      # Tiết kiệm RAM
      "--process-per-site"
    ];

    # Tự động cài các Extension quan trọng
    extensions = [
      # 1. uBlock Origin (Chặn quảng cáo -> Giảm tải CPU load trang web)
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }

      # 2. enhanced-h264ify (QUAN TRỌNG NHẤT CHO X230)
      # Extension này ép YouTube phát chuẩn H.264 (HD4000 có hỗ trợ phần cứng)
      # thay vì VP9 (HD4000 không hỗ trợ -> CPU phải gánh 100%)
      { id = "omkfmpieigblcllmkgbflkikinpkodjg"; }

      # 3. Vimium (Lướt web bằng bàn phím - Tùy chọn, hợp với DWM)
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; }
    ];
  };


  # --- CẤU HÌNH BRAVE TỐI ƯU CHO THINKPAD X230 ---
  # 3. Symlink Configuration (Clean Home Strategy)
  # ---------------------------------------------------------------------
  home.file = {
    # Pointer cho Zsh (Triết lý: Không để file rác ở Home)
    ".zshenv".text = ''
      export ZDOTDIR="$HOME/.config/zsh"
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
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/bin/.local/share/newsboat"; # (Path hơi lạ, nhưng giữ nguyên ý bạn)

    # -- X11 & Scripts --
    ".xinitrc".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/x11/.config/x11/xinitrc";
    ".xprofile".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/x11/.config/x11/xprofile";
    ".config/x11".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/x11/.config/x11";

    # Scripts custom (Tách biệt để dễ quản lý trong PATH)
    ".local/bin/base".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/bin/.local/bin";
    ".local/bin/user".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfiles}/user-bin/.local/bin/user";
  };

  # 4. Environment Variables & Path
  # ---------------------------------------------------------------------

  # Thêm đường dẫn vào PATH (Ưu tiên local bin tự compile > scripts > system)
  home.sessionPath = [
    "$HOME/.local/bin" # DWM, ST (Compiled manually)
    "$HOME/.local/bin/base" # General Scripts
    "$HOME/.local/bin/user" # User Scripts (ka-*)
    "$HOME/go/bin" # Go Tools (Fallback nếu cài tay)
    "$HOME/.cargo/bin" # Rust Tools (Fallback)
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "st";
    BROWSER = "brave";
    # Fix Java apps (IntelliJ, Minecraft...) bị lỗi hiển thị trong DWM
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  # 5. Theming (GTK & Icons)
  # ---------------------------------------------------------------------
  gtk = {
    enable = true;
    theme = {
      name = "Arc-Dark";
      package = pkgs.arc-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    # Cấu hình Font cho GTK Apps
    font = {
      name = "Inter";
      size = 11;
    };
  };

  home.stateVersion = "25.11";
}
