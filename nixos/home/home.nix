# ---
# User (home.nix): Chứa toàn bộ ứng dụng người dùng, giao diện, dev tools.
# ---

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
    # --- Web Browser ---
    # librewolf # (Đã có script wrapper riêng, có thể uncomment nếu muốn cài native)
    # brave     # (Cài qua module programs.brave bên dưới sẽ tốt hơn)

    # --- Database Management ---
    dbeaver-bin

    # --- Media ---
    nsxiv       # Xem ảnh (Suckless style)
    zathura     # Đọc PDF (Vim keybindings)
    mpv         # Xem Video (Nhẹ, scriptable)
    calcurse    # Lịch (TUI)
    pavucontrol # Chỉnh âm thanh (GUI cho Pipewire)
  ];

  # =====================================================================
  # 2. DESKTOP UTILITIES (The "Glue" of DWM)
  # Nhóm này chứa các công cụ hỗ trợ giao diện, chạy nền, script backend
  # =====================================================================
  desktopUtilities = with pkgs; [
    # --- Core UI ---
    picom                   # Compositor 
    rofi                    # App Launcher & Menu
    dunst                   # Notification Daemon
    trayer                  # System Tray (cho các app như nm-applet)
    xwallpaper              # Wallpaper setter (nhẹ hơn feh)
    arandr                  # GUI chỉnh màn hình (tạo script xrandr)
    networkmanagerapplet    # Icon Wifi trên tray

    # --- Scripting & Backend UI ---
    yad                     # Tạo hộp thoại GUI cho script (quan trọng)
    libnotify               # Lệnh notify-send

    # --- Clipboard Manager ---
    clipmenu                # Quản lý lịch sử copy (dùng dmenu/rofi)
    xclip                   # Backend copy/paste cho X11

    # --- Screenshot & Automation ---
    maim                    # Chụp ảnh màn hình (tốt hơn scrot)
    slop                    # Chọn vùng màn hình (dùng với maim)
    xdotool                 # Giả lập phím/chuột (cho script)
    brightnessctl           # Chỉnh độ sáng màn hình
    
    # --- System Monitoring ---
    pkgs.libva-utils        # Kiểm tra driver đồ họa (vainfo)

    # Go tieng viet
    fcitx5
    fcitx5-gtk
    fcitx5-bamboo
    # fcitx5-unikey
    qt6Packages.fcitx5-configtool
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
    lf              # File manager (Ranger like)
    ueberzugpp      # Preview ảnh cho LF
    atool           # Quản lý nén file đa năng
    unzip
    unrar
    
    # --- Media Processing ---
    ffmpeg
    ffmpegthumbnailer
    imagemagick
    poppler-utils   # pdftoppm (preview pdf)
    mediainfo
    ghostscript

    # --- Network & Text Processing ---
    newsboat        # RSS Reader
    neomutt         # Email Client
    jq              # Xử lý JSON
    socat           # Socket cat
    bc              # Máy tính
    file
    rsync
    
    # --- Utilities ---
    util-linux      # setsid, v.v.
    sqlite
    tectonic        # LaTeX engine hiện đại
  ];

  # =====================================================================
  # 4. AUDIO TOOLS (CLI)
  # =====================================================================
  audioTools = with pkgs; [
    pulsemixer      # TUI Mixer (nhẹ)
    pamixer         # CLI Volume control
    wireplumber     # Quản lý session Pipewire
    mpc             # Điều khiển MPD
    ncmpcpp         # Giao diện nghe nhạc MPD
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
    gcc             # Cần cho Treesitter / CGO
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
    nil             # Nix LSP
  ];

  # =====================================================================
  # 7. FORMATTERS & LINTERS
  # =====================================================================
  formattersAndLinters = with pkgs; [
    stylua
    gotools         # goimports
    nodePackages.prettier
    nodePackages.eslint_d
    shellcheck
    shfmt
    ruff            # Python linter (nhanh)
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
    tree-sitter     # CLI
  ];

in
{
  home.username = "ka";
  home.homeDirectory = "/home/ka";

  # =====================================================================
  # IMPORT MODULES
  # Tách biệt cấu hình giao diện ra file riêng cho gọn
  # =====================================================================
  imports = [
    ./theme.nix  # <-- File cấu hình GTK/Cursor/Font bạn vừa tạo
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
  # CẤU HÌNH BRAVE (TỐI ƯU CHO THINKPAD X230 / HD4000)
  # =====================================================================
  programs.brave = {
    enable = true;
    commandLineArgs = [
      "--enable-features=VaapiVideoDecodeLinuxGL" # VA-API Video Decode
      "--use-gl=egl"
      "--ignore-gpu-blocklist"                    # Ép chạy GPU cũ
      "--enable-gpu-rasterization"
      "--enable-zero-copy"
      "--process-per-site"                        # Tiết kiệm RAM
    ];
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
      { id = "omkfmpieigblcllmkgbflkikinpkodjg"; } # enhanced-h264ify (QUAN TRỌNG)
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # Vimium
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
    '';

    # -- Shell & Core --
    ".config/zsh".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/zsh/.config/zsh";
    ".config/shell".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/shell/.config/shell";

    # -- Applications --
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/nvim/.config/nvim";
    ".config/lf".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/lf/.config/lf";
    ".config/rofi".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/rofi/.config/rofi";
    ".config/dunst".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/dunst/.config/dunst";
    ".config/librewolf".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/librewolf/.config/librewolf";
    ".config/tmux".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/tmux/.config/tmux";

    # -- Media --
    ".config/mpd".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/media/.config/mpd";
    ".config/ncmpcpp".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/media/.config/ncmpcpp";
    ".config/mpv".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/media/.config/mpv";
    ".config/nsxiv".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/nsxiv/.config/nsxiv";
    ".config/newsboat".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/bin/.local/share/newsboat";

    # -- X11 & Scripts --
    ".xinitrc".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/x11/.config/x11/xinitrc";
    ".xprofile".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/x11/.config/x11/xprofile";
    ".config/x11".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/x11/.config/x11";

    # -- Custom Scripts (Tách biệt) --
    ".local/bin/base".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/bin/.local/bin";
    ".local/bin/user".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/user-bin/.local/bin";
  };

  # =====================================================================
  # ENVIRONMENT VARIABLES & PATH
  # =====================================================================
  home.sessionPath = [
    "$HOME/.local/bin"       # DWM, ST (Compiled)
    "$HOME/.local/bin/base"  # Base Scripts
    "$HOME/.local/bin/user"  # User Scripts
    "$HOME/go/bin"           # Go Tools
    "$HOME/.cargo/bin"       # Rust Tools
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "st";
    BROWSER = "brave";
    # Fix Java apps (IntelliJ, Minecraft...) bị lỗi hiển thị trong DWM
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  # (Đã xóa phần gtk = { ... } vì đã chuyển sang theme.nix)

  home.stateVersion = "25.11";
}
