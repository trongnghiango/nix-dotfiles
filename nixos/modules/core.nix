# ------
# System (core.nix): Chỉ chứa driver, kernel, công cụ cứu hộ (vim, git) và những thứ cần quyền root.
# ------
{ config, pkgs, ... }:

{
  time.timeZone = "Asia/Ho_Chi_Minh";
  i18n.defaultLocale = "en_US.UTF-8";

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # --- MỚI: nix-ld (Cứu cánh cho các binary tải ngoài Nix) ---
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    openssl
    curl
  ];

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
  };

  # SSH (Giữ nguyên của bạn)
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "yes";
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 ];

  # Gói hệ thống cốt lõi (Giữ nguyên build tools cho DWM/ST)
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    gnumake
    gcc
    pkg-config
    xorg.libX11
    xorg.libX11.dev
    xorg.libXinerama
    xorg.libXinerama.dev
    xorg.libXft
    xorg.libXft.dev
    xorg.xrandr
    xorg.xsetroot
    unzip
    unrar
    dash
    tree
    tmux
    android-tools
  ];
}
