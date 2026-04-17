{
  config,
  pkgs,
  dotfiles,
  ...
}:

{
  home.packages = with pkgs; [
    fzf
    eza
    bat
    zoxide
    fnm
  ];

  # 1. TẮT MODULE ZSH CỦA HOME MANAGER ĐỂ NÓ KHÔNG PHÁ MÀY NỮA
  programs.zsh.enable = false;

  # 2. ĐƯA XDG_CONFIG_HOME RA NGOÀI ĐỂ ĐỒNG BỘ
  home.sessionVariables = {
    XDG_CONFIG_HOME = "$HOME/.config";
  };

  home.file = {
    # 3. TỰ TẠO FILE .zshenv THỦ CÔNG (Đéo sợ xung đột)
    ".zshenv".text = ''
      export ZDOTDIR="$HOME/.config/zsh"
      export XDG_CONFIG_HOME="$HOME/.config"
      [ -f "$XDG_CONFIG_HOME/shell/profile" ] && . "$XDG_CONFIG_HOME/shell/profile"
    '';

    # 4. LINK CÁC FOLDER TỪ DOTFILES (GIỮ NGUYÊN CÁCH CŨ MÀY THÍCH)
    ".config/zsh".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/zsh/.config/zsh";
    ".config/shell".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/shell/.config/shell";
    ".config/tmux".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/tmux/.config/tmux";
  };

  programs.zoxide.enable = true;
}
