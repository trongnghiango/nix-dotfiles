{ config, pkgs, ... }:

{
  # ====================================================================
  # 1. KÍCH HOẠT ZSH (SYSTEM LEVEL)
  # ====================================================================
  # Bắt buộc phải có để NixOS thêm zsh vào /etc/shells
  programs.zsh.enable = true;

  # Lưu ý: KHÔNG bật autosuggestions, syntaxHighlighting ở đây nữa.
  # Để Home Manager quản lý việc đó cho từng user.
  # Điều này giúp root user (khi sudo -i) sạch sẽ, không bị lỗi config của user thường.

  # ====================================================================
  # 2. THIẾT LẬP MẶC ĐỊNH
  # ====================================================================
  users.defaultUserShell = pkgs.zsh;

  # ====================================================================
  # 3. GÓI HỆ THỐNG CỐT LÕI (SYSTEM PACKAGES)
  # ====================================================================
  # Chỉ cài những thứ thực sự cần cho Root hoặc Cứu hộ hệ thống.
  # (User 'ka' đã có đủ đồ chơi trong home.nix rồi)
  environment.systemPackages = with pkgs; [
    vim       # Editor dự phòng (nếu nvim lỗi)
    git       # Để clone cấu hình
    curl
    wget
    psmisc    # Chứa lệnh killall
  ];

  # ====================================================================
  # 4. BIẾN MÔI TRƯỜNG TOÀN CỤC
  # ====================================================================
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
  
  # XÓA: environment.etc."zshenv".text
  # Lý do: Đã chuyển sang programs.zsh.envExtra trong home.nix
  # Việc ghi đè /etc/zshenv là không cần thiết và gây khó debug.
}
