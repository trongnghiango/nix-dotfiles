{
  config,
  pkgs,
  dotfiles,
  user,
  ...
}:

{
  imports = [
    ../modules/home/shell/zsh.nix # Mày tự tạo file này theo hướng dẫn trước
    ../modules/home/editors/nvim.nix # Mày tự tạo file này theo hướng dẫn trước
  ];

  home.username = "${user}";
  home.homeDirectory = "/home/${user}";

  # Các công cụ CLI hệ thống
  home.packages = with pkgs; [
    # Core system
    git wget curl htop btop tree trash-cli rsync
    # File manager (Hàng xịn của mày đây)
    lf ueberzugpp 
    # Archivers
    unzip unrar atool
    # Search & Processing
    ripgrep fd fzf bat eza zoxide jq socat bc file
    # Utilities
    util-linux tectonic
  ];

  # Biến môi trường chung
  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "st";
  };

  home.stateVersion = "25.11";
}
