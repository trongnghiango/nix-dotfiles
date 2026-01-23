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
