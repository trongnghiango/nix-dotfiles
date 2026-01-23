{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  environment.etc."zshenv".text = ''
    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_CACHE_HOME="$HOME/.cache"
    export XDG_DATA_HOME="$HOME/.local/share"

    if [[ -d "$XDG_CONFIG_HOME/zsh" ]]; then
      export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
    fi

    # CLEAN CODE: Đặt PATH hệ thống lên trước để tránh xung đột binary cũ - nhung thuc te thi phai dat sau vi de overide lai hoac la nhung file run moi
    export PATH="$HOME/.dotfiles/bin/.local/bin:$HOME/.dotfiles/user-bin/.local/bin:$HOME/.local/bin:$PATH"

    # Load profile (nơi chứa lệnh exec startx)
    if [[ -f "$XDG_CONFIG_HOME/shell/profile" ]]; then
      source "$XDG_CONFIG_HOME/shell/profile"
    fi
    # --------------------------------------------
  '';

  # Các tool CLI hiện đại (cài cho toàn hệ thống để user nào cũng dùng được)
  environment.systemPackages = with pkgs; [
    fzf eza bat zoxide fnm
  ];

  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
}
