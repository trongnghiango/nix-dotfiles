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
    experimental-features = [ "nix-command" "flakes" ];
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
      monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
      serif = [ "Noto Serif" "Noto Color Emoji" ];
      sansSerif = [ "Inter" "Noto Color Emoji" ];
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
