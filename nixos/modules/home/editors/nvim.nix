{
  config,
  pkgs,
  dotfiles,
  ...
}:

{
  # 1. Cài đặt Neovim và các công cụ bổ trợ (Essentials)
  home.packages = with pkgs; [
    neovim
    ripgrep # Cần cho Telescope
    fd # Cần cho Telescope
    tree-sitter # Cần cho Syntax Highlighting
    lazygit # Công cụ Git thần thánh
  ];

  # 2. SYMLINK CONFIG (Sửa nvim config trong dotfiles là máy nhận ngay)
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/nvim/.config/nvim";

  # 3. Biến môi trường
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
