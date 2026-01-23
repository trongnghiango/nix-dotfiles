# ------
# System (core.nix): Chỉ chứa driver, kernel, công cụ cứu hộ (vim, git) và những thứ cần quyền root.
# ------
{ config, pkgs, ... }:

{
  time.timeZone = "Asia/Ho_Chi_Minh";
  i18n.defaultLocale = "en_US.UTF-8";

  nixpkgs.config.allowUnfree = true;

  # --- PRO TIP: Tự động tối ưu và dọn rác ---
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true; # Tự động gộp file trùng nhau -> Tiết kiệm ổ cứng
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # --- Nix-ld: Để chạy binary tải ngoài (Mason, VSCode server...) ---
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    openssl
    curl
    glib
  ];

  # =====================================================================
  # CẤU HÌNH FONT (Hệ thống cần cái này để hiển thị đúng)
  # =====================================================================
  # 1. CÀI GÓI FONT
  fonts.packages = with pkgs; [
    # Font chính cho Code/Terminal (Bao gồm Icon)
    nerd-fonts.jetbrains-mono 

    # Font cho DWM Status Bar ( tôi khuyên dùng Iosevka hoặc Blex)
    nerd-fonts.iosevka 
    nerd-fonts.blex-mono

    # Font cho giao diện đẹp (UI)
    inter
    
    # Font dự phòng cho tiếng Việt, Nhật, Hàn, Trung
    noto-fonts
    noto-fonts-cjk-sans
    
    # Font Emoji màu (Quan trọng để chat, web không bị lỗi ô vuông)
    noto-fonts-color-emoji
  ];

  # 2. THIẾT LẬP MẶC ĐỊNH (QUAN TRỌNG ĐỂ ĐỒNG BỘ)
  # Cái này giúp app nào không config font sẽ tự lấy đúng cái này
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
      serif = [ "Noto Serif" "Noto Color Emoji" ];
      sansSerif = [ "Inter" "Noto Color Emoji" ];
    };


  # --- SSH Security ---
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no"; # Bảo mật: Không cho root login từ xa
    };
  };
  networking.firewall.allowedTCPPorts = [ 22 ];

  # --- SYSTEM PACKAGES (Chỉ giữ lại Core Tools) ---
  # Xóa hết các lib X11/dev thừa, home.nix đã lo việc đó
  environment.systemPackages = with pkgs; [
    vim       # Editor dự phòng
    git
    wget
    curl
    htop      # Monitor dự phòng
  ];
}
